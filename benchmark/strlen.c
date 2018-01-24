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

int main(int argc, char** argv)
{
	struct timespec time1;
	struct timespec time2;
	struct timespec dt;
	volatile size_t result;

	unsigned long old;
	unsigned long t1 = 0;

	double dt1;

#ifdef SAFEC
	unsigned long t2 = 0;
	double dt2;
#endif

	unsigned long i;
	unsigned long runs = 5000;

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

	for(i = 0; i < runs; i++) {
		clock_gettime(THE_CLOCK, &time1);
		result = strlen(value);
		clock_gettime(THE_CLOCK, &time2);
		dt = diff(time1, time2);
#ifdef PRINT_RUNS
		printf("normal: %lu:%lu (result=%lu)\n", dt.tv_sec, dt.tv_nsec, result);
#endif

		if(dt.tv_sec) {
			printf("error! strlen took too long!\n");
			return 1;
		}

		old = t1;
		t1 += dt.tv_nsec;
		if(old > t1) {
			printf("error! overflow!\n");
			return 1;
		}
	}

	dt1 = (double) t1 / (double) runs;

#ifdef SAFEC
	for(i = 0; i < runs; i++) {
		clock_gettime(THE_CLOCK, &time1);
		result = __safe_strlen(value);
		clock_gettime(THE_CLOCK, &time2);
		dt = diff(time1, time2);
#ifdef PRINT_RUNS
		printf("safe: %lu:%lu (result=%lu)\n", dt.tv_sec, dt.tv_nsec, result);
#endif

		if(dt.tv_sec) {
			printf("error! strlen took too long!\n");
			return 1;
		}

		old = t2;
		t2 += dt.tv_nsec;
		if(old > t2) {
			printf("error! overflow!\n");
			return 1;
		}
	}

	dt2 = (double) t2 / (double) runs;

	printf("%g vs %g: %g\n", dt1, dt2, dt2 / dt1);
#else
	printf("%g\n", dt1);
#endif

	free(value);

	return 0;
}
