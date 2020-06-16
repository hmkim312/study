import socketserver

HOST = ''
PORT = 9009

class MyTcpHandler(socketserver.BaseRequestHandler):
    # 이 클래스는 서버 하나당 단 한번 초기화 됩니다.
    # handle 메소드에 클라이언트 연결 처리를 위한 로직을 구현합니다.
    
    def handle(self):
        print(f'[{self.client_address[0]}에 연결됨]')
        
        try :
            while True:
                self.data = self.request.recv(1024)
                if self.data.decode() == '/quit':
                    print(f'[{self.client_address[0]}]사용자에 의해 중단')
                    return
                
                print(f'[{self.data.decode()}]')
                self.request.sendall(self.data)
        except Exception as e:
            print(e)
            
def runserver():
    print('+++에코 서버를 시작합니다.')
    print('+++에코 서버를 끝내려면 Ctrl + C를 누르세요.')

    try:
        server = socketserver.TCPServer((HOST,PORT), MyTcpHandler)
        server.serve_forever()
    except KeyboardInterrupt :
        print('+++ 에코 서버를 종료 합니다.')
            
runserver()