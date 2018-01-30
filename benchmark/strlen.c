#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

size_t __safe_strlen(const char*);

struct timespec diff(struct timespec start, struct timespec end)
{
	struct timespec temp;
	if((end.tv_nsec - start.tv_nsec) < 0) {
		temp.tv_sec = end.tv_sec - start.tv_sec - 1;
		temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
	} else {
		temp.tv_sec = end.tv_sec - start.tv_sec;
		temp.tv_nsec = end.tv_nsec - start.tv_nsec;
	}
	return temp;
}

#define THE_CLOCK	CLOCK_PROCESS_CPUTIME_ID

#ifdef SOFTBOUND
    #define SYSTEM_TYPE "softbound+cets"
#endif
#ifdef CLANG 
    #define SYSTEM_TYPE "clang"
#endif
#ifdef ASAN
    #define SYSTEM_TYPE "asan"
#endif
#ifdef MPX
    #define SYSTEM_TYPE "mpx"
#endif


#ifdef INTROSPECTION
    #define INTROSPECTION_TYPE "introspection"
#endif
#ifdef NO_INTROSPECTION
    #define INTROSPECTION_TYPE "original"
#endif
#ifdef ORIGINAL
    #define INTROSPECTION_TYPE ""
#endif



int main(int argc, char** argv)
{
	struct timespec time1;
	struct timespec time2;
	struct timespec dt;
	volatile size_t result;


	volatile unsigned long i;
	unsigned long runs = 5000000;

	int size;
	char* value;

	if(argc != 2) {
		printf("Error: usage: %s string-length\n", *argv);
		return 1;
	}

	size = atoi(argv[1]);

	value = (char*) malloc(size);

	memset(value, 'A', size);
	value[size - 1] = 0;

    clock_gettime(THE_CLOCK, &time1);
	for(i = 0; i < runs; i++) {
#ifdef SAFEC
		result = __safe_strlen(value);
#else
		result = strlen(value);
#endif
    }
    clock_gettime(THE_CLOCK, &time2);
    dt = diff(time1, time2);
    long milliseconds = dt.tv_sec * 1000 + dt.tv_nsec/1000000;
    printf("%s;%s;%lu\n", SYSTEM_TYPE, INTROSPECTION_TYPE, milliseconds);
	

	free(value);

	return 0;
}
