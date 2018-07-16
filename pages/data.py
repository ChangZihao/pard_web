import time 
import random

f =  open('monitor_1_latency.json', 'r+')

while True:
    #t = int(time.time() * 1000)
    latency = random.randint(1, 500)

    s = '{"latency": %d}' %(latency)
    time.sleep(1)
        
    f.seek(0)
    f.write(s)
    f.truncate()

    #f.write
