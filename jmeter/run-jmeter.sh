JMETER=apache-jmeter-3.3/bin/jmeter
EVALUATION=$HOME/git/safe-libc-evaluation
OUTPUT_DIR=output
killall fftp java dnsmasq
CAPTURE_OUTPUT=false
OUTPUT_FILE="output.csv"

cleanup() {
    sleep 180
    killall -9 java dnsmasq fftp >/dev/null
    sudo netstat -ap | grep :54
    sudo netstat -ap | grep :21
}

logfile() {
    if [ "$CAPTURE_OUTPUT" = true ] ; then
        echo $0
    else
        echo "/dev/null"
    fi
}

########################### dnsmasq ###################################

#echo "benchmark;system;introspection;threads;throughput" > $OUTPUT_FILE
for run in `seq 1 10`;
do
    rm -rf output/*
    echo "starting run $run"
    killall -9 java dnsmasq fftp
    echo "start evaluation of dnsmasq"
    echo "-> asan (introspection)"

    # 1 thread (introspection)
    $EVALUATION/cve/asan/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-asan-introspection-singlethreaded-console` &
    $JMETER -n -t dnsmasq-singlethreaded.jmx -l output/dnsmasq-asan-introspection-singlethreaded.txt -e -o output/dnsmasq-asan-introspection-singlethreaded
    cleanup

    # 10 threads (introspection)
    $EVALUATION/cve/asan/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-asan-introspection-threaded-console` &
    $JMETER -n -t dnsmasq-threaded.jmx -l output/dnsmasq-asan-introspection-threaded.txt -e -o output/dnsmasq-asan-introspection-threaded
    cleanup

    # 1 thread (no introspection)
    $EVALUATION/cve/asan-no-introspection/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-asan-nointrospection-singlethreaded-console` &
    $JMETER -n -t dnsmasq-singlethreaded.jmx -l output/dnsmasq-asan-nointrospection-singlethreaded.txt -e -o output/dnsmasq-asan-nointrospection-singlethreaded
    cleanup

    # 10 threads (no introspection)
    $EVALUATION/cve/asan-no-introspection/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-asan-nointrospection-threaded-console` &
    $JMETER -n -t dnsmasq-threaded.jmx -l output/dnsmasq-asan-nointrospection-threaded.txt -e -o output/dnsmasq-asan-nointrospection-threaded
    cleanup

    # 1 thread (no introspection)
    $EVALUATION/cve/clang-no-introspection/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-clang-nointrospection-singlethreaded-console` &
    $JMETER -n -t dnsmasq-singlethreaded.jmx -l output/dnsmasq-clang-nointrospection-singlethreaded.txt -e -o output/dnsmasq-clang-nointrospection-singlethreaded
    cleanup

    # 10 threads (no introspection)
    $EVALUATION/cve/clang-no-introspection/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-clang-nointrospection-threaded-console` &
    $JMETER -n -t dnsmasq-threaded.jmx -l output/dnsmasq-clang-nointrospection-threaded.txt -e -o output/dnsmasq-clang-nointrospection-threaded
    cleanup

    echo "-> mpx (introspection)"
    # 1 thread (introspection)
    $EVALUATION/cve/mpx/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-mpx-introspection-singlethreaded-console` &
    $JMETER -n -t dnsmasq-singlethreaded.jmx -l output/dnsmasq-mpx-introspection-singlethreaded.txt -e -o output/dnsmasq-mpx-introspection-singlethreaded
    cleanup

    echo "-> mpx (no introspection)"
    # 1 thread (no introspection)
    $EVALUATION/cve/mpx-no-introspection/dnsmasq-2.77/src/dnsmasq --no-daemon --dhcp-range=fd00::2,fd00::ff -p 54 > `logfile output/dnsmasq-mpx-introspection-singlethreaded-nointrospection-console` &
    $JMETER -n -t dnsmasq-singlethreaded.jmx -l output/dnsmasq-mpx-introspection-singlethreaded-nointrospection.txt -e -o output/dnsmasq-mpx-introspection-singlethreaded-nointrospection
    cleanup


    ########################### LightFTP ###################################

    echo "start asan evaluation of LightFTP"


    # 1 thread (no introspection)
    $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-asan-nointrospection-singlethreaded-console` &
    $JMETER -n -t lightftp-singlethreaded.jmx -l output/lightftp-asan-nointrospection-singlethreaded.txt -e -o output/lightftp-asan-nointrospection-singlethreaded
    cleanup

    # 4 threads (no introspection)
    $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-asan-nointrospection-threaded-console` &
    $JMETER -n -t lightftp-threaded.jmx -l output/lightftp-asan-nointrospection-threaded.txt -e -o output/lightftp-asan-nointrospection-threaded
    cleanup

    # 1 thread (no introspection)
    $EVALUATION/cve/clang-no-introspection/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/clang-no-introspection/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-clang-nointrospection-singlethreaded-console` &
    $JMETER -n -t lightftp-singlethreaded.jmx -l output/lightftp-clang-nointrospection-singlethreaded.txt -e -o output/lightftp-clang-nointrospection-singlethreaded
    cleanup

    # 4 threads (no introspection)
    $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/asan-no-introspection/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-clang-nointrospection-threaded-console` &
    $JMETER -n -t lightftp-threaded.jmx -l output/lightftp-clang-nointrospection-threaded.txt -e -o output/lightftp-clang-nointrospection-threaded
    cleanup


    # 1 thread (introspection)
    $EVALUATION/cve/asan/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/asan/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-asan-introspection-singlethreaded-console` &
    $JMETER -n -t lightftp-singlethreaded.jmx -l output/lightftp-asan-introspection-singlethreaded.txt -e -o output/lightftp-asan-introspection-singlethreaded
    cleanup

    # 4 threads (introspection)
    $EVALUATION/cve/asan/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/asan/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-asan-introspection-threaded-console` &
    $JMETER -n -t lightftp-threaded.jmx -l output/lightftp-asan-introspection-threaded.txt -e -o output/lightftp-asan-introspection-threaded
    cleanup

    echo "start mpx evaluation of LightFTP"

    # 1 thread (no introspection)
    $EVALUATION/cve/mpx-no-introspection/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/mpx-no-introspection/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-mpx-instrospection-singlethreaded-nointrospection-console` &
    $JMETER -n -t lightftp-singlethreaded.jmx -l output/lightftp-mpx-introspection-singlethreaded-nointrospection.txt -e -o output/lightftp-mpx-instrospection-singlethreaded-nointrospection
    cleanup

    # 1 thread (introspection)
    $EVALUATION/cve/mpx/LightFTP-1.1/Source/Other/Release/fftp $EVALUATION/cve/mpx/LightFTP-1.1/Source/Other/Release/fftp.cfg > `logfile output/lightftp-mpx-instrospection-singlethreaded-console` &
    $JMETER -n -t lightftp-singlethreaded.jmx -l output/lightftp-mpx-introspection-singlethreaded.txt -e -o output/lightftp-mpx-instrospection-singlethreaded
    cleanup
    
    python3 ./parse-results.py >> $OUTPUT_FILE
done


