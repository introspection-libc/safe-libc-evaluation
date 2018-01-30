import subprocess
import statistics

# first is baseline
executables = ['strlen-clang', 'strlen-asan', 'strlen-asan-introspection', 'strlen-softbound', 'strlen-mpx', 'strlen-mpx-introspection', 'strlen-softbound-introspection']
string_lengths = [10, 100, 10000]
baseline = [0] * len(string_lengths)

out_file = open('out.csv', 'w')
out_file.write('length;system;introspection;milliseconds\n')
got_baseline = False

for executable in executables:
    length_idx = 0
    for string_length in string_lengths:
        milliseconds = []
        for i in range(10):
            p = subprocess.Popen('./' + executable + ' ' + str(string_length), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            line = p.stdout.read().decode("utf-8").rstrip('\n')
            system = line.split(';')[0]
            introspection_type = line.split(';')[1]
            millisecond = int(line.split(';')[2])
            milliseconds.append(millisecond)
            if got_baseline:
                normalized_milliseconds = float(millisecond) / baseline[length_idx]
                print(normalized_milliseconds)
                out_file.write("%d;%s;%s;%f\n" % (string_length, system, introspection_type, normalized_milliseconds))
        if not got_baseline:
            baseline[length_idx] = statistics.median(milliseconds)
        length_idx += 1
    got_baseline = True
        
out_file.close()
