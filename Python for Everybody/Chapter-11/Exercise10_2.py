name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)
times = dict()
for line in handle:
    if line.startswith('From '):
        time = line.split(' ')[6].split(':')[0];
        times[time] = times.get(time, 0) + 1
        
sortedTimes = sorted(times.items())
for k,v in sortedTimes:
    print(k, v)