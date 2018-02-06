import re
import os.path

def extract_throughput_from_dir(resultdir):
    f = open(os.path.join(resultdir, 'content/js/dashboard.js'))
    lines = f.readlines()
    for line in lines:
        if "createTable($(\"#statisticsTable\")" in line:
            m = re.search('\["Total", (.*?)\],', line)
            match = m.group(1)
            tokens = match.split(',')
            return float(tokens[9])

print("lightftp;clang;;1 thread;%f" % extract_throughput_from_dir("output/lightftp-clang-nointrospection-singlethreaded"))
print("lightftp;mpx;introspection;1 thread;%f" % extract_throughput_from_dir("output/lightftp-mpx-instrospection-singlethreaded"))
print("lightftp;mpx;original;1 thread;%f" % extract_throughput_from_dir("output/lightftp-mpx-instrospection-singlethreaded-nointrospection"))
print("lightftp;asan;introspection;1 thread;%f" % extract_throughput_from_dir("output/lightftp-asan-introspection-singlethreaded"))
print("lightftp;asan;original;1 thread;%f" % extract_throughput_from_dir("output/lightftp-asan-nointrospection-singlethreaded"))
print("lightftp;clang;;4 threads;%f" % extract_throughput_from_dir("output/lightftp-clang-nointrospection-threaded"))
print("lightftp;asan;introspection;4 threads;%f" % extract_throughput_from_dir("output/lightftp-asan-introspection-threaded"))
print("lightftp;asan;original;4 threads;%f" % extract_throughput_from_dir("output/lightftp-asan-nointrospection-threaded"))

print("dnsmasq;clang;;1 thread;%f" % extract_throughput_from_dir("output/dnsmasq-clang-nointrospection-singlethreaded"))
print("dnsmasq;mpx;introspection;1 thread;%f" % extract_throughput_from_dir("output/dnsmasq-mpx-introspection-singlethreaded"))
print("dnsmasq;mpx;original;1 thread;%f" % extract_throughput_from_dir("output/dnsmasq-mpx-introspection-singlethreaded-nointrospection"))
print("dnsmasq;asan;introspection;1 thread;%f" % extract_throughput_from_dir("output/dnsmasq-asan-introspection-singlethreaded"))
print("dnsmasq;asan;original;1 thread;%f" % extract_throughput_from_dir("output/dnsmasq-asan-nointrospection-singlethreaded"))
print("dnsmasq;asan;introspection;4 threads;%f" % extract_throughput_from_dir("output/dnsmasq-asan-introspection-threaded"))
print("dnsmasq;asan;original;4 threads;%f" % extract_throughput_from_dir("output/dnsmasq-asan-nointrospection-threaded"))
print("dnsmasq;clang;;4 threads;%f" % extract_throughput_from_dir("output/dnsmasq-clang-nointrospection-threaded"))
