import socket

HOST = ''
PORT = 9009

def runserver():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.bind((HOST,PORT))
        sock.listen(1)
        print('클라이언트 연결을 기다리는중')
        conn, addr = sock.accept()
        with conn:
            print(f'{addr[0]}과 연결됨')
            while conn:
                data = conn.recv(1024)
                if not data :
                    break
                print(f'메세지 수신{data.decode()}')
                conn.sendall(data)
runserver()