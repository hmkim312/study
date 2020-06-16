import socketserver
import threading

HOST = ''
PORT = 9009
lock = threading.Lock()

class UserManager:
    def __init__(self):
        self.users = {}
    
    def adduser(self, username, conn, addr):
        if username in self.users:
            conn.send('이미 등록된 사용자 입니다.\n'.encode())
            return None
        
        # 새로운 사용자를 등록
        lock.acquire()
        self.users[username] = (conn, addr)
        lock.release()
        
        self.sendmessagetoall(f'[{username}]님이 입장하셨습니다.')
        print(f'+++ 대화 참여자 수 : [{len(self.users)}]')
        
        return username
    
    def removeuser(self, username):
        if username not in self.users:
            return
        lock.acquire()
        del self.users[username]
        lock.release()
        
        self.sendmessagetoall(f'[{username}]님이 퇴장했습니다.')
        print(f'+++ 대화 참여자 수 : [{len(self.users)}]')
        
    def messagehandler(self, username, msg):
        if msg[0] != '/':
            self.sendmessagetoall(f'[{username}] : {msg}')
            return
        
        if msg.strip() == '/quit':
            self.removeuser(username)
            return -1
        
    def sendmessagetoall(self, msg):
        for conn, addr in self.users.values():
            conn.send(msg.encode())
            
class MyTcpHandler(socketserver.BaseRequestHandler):
    userman = UserManager()
    
    def handle(self):
        print(f'[{self.client_address[0]}]에 연결됨')
        
        try:
            username = self.registerusername()
            msg = self.request.recv(1024)
            while msg:
                print(msg.decode())
                if self.userman.messagehandler(username, msg.decode()) == -1:
                    self.request.close()
                    break
                msg = self.request.recv(1024)
        except Exception as e:
            print(e)
            
        print(f'[{self.client_address[0]}] 접속 종료')
        self.userman.removeuser(username)
        
    def registerusername(self):
        while True:
            self.request.send('로그인ID:'.encode())
            username = self.request.recv(1024)
            username = username.decode().strip()
            if self.userman.adduser(username, self.request, self.client_address):
                return username
            
class ChatingServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass

def runserver():
    print('+++채팅 서버를 시작합니다.')
    print('+++채팅 서버를 종료하려면 Ctrl + C를 누르세요.')
    
    try :
        server = ChatingServer((HOST, PORT), MyTcpHandler)
        server.serve_forever()
        
    except KeyboardInterrupt:
        print('+++채팅 서버를 종료 합니다.')
        server.shutdown()
        server.server_close()
        
runserver()