import socket

HOST = 'localhost'
PORT = 9009

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect((HOST, PORT))
    
    while True:
        msg = input('메시지 입력하세요 : ')
        if msg == '/quit':
            sock.sendall(msg.encode())
            break

        sock.sendall(msg.encode())
        data = sock.recv(1024)
        print(f'에코 서버로 부터 받은 데이터[{data.decode()}]')
    
print('클라이언트 종료')