import socket

HOST = 'localhost'
PORT = 9009

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock :
    sock.connect((HOST, PORT))
    msg = input('메시지 입력 : ')
    sock.sendall(msg.encode())
    data = sock.recv(1024)

print(f'에코 서버로 받은 데이터 [{data.decode()}]')