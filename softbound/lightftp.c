#define _POSIX_C_SOURCE 200809L

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <time.h>
#include <linux/limits.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>

#define SOCKET int

typedef struct  _FTPCONTEXT {
        pthread_mutex_t         MTLock;
        SOCKET                  ControlSocket;
        SOCKET                  DataSocket;
        pthread_t               WorkerThreadId;
        /*
         * WorkerThreadValid is output of pthread_create
         * therefore zero is VALID indicator and -1 is invalid.
         */
        int                     WorkerThreadValid;
        int                     WorkerThreadAbort;
        in_addr_t               ServerIPv4;
        in_addr_t               ClientIPv4;
        in_addr_t               DataIPv4;
        in_port_t               DataPort;
        int                     File;
        int                     Mode;
        int                     Access;
        int                     SessionID;
        off_t                   RestPoint;
        char                    CurrentDir[PATH_MAX];
        char                    RootDir[PATH_MAX];
        char                    *GPBuffer;
} FTPCONTEXT, *PFTPCONTEXT;

static const char CRLF[] = "\r\n";

size_t ultostr(unsigned long x, char *s)
{
        unsigned long   t=x;
        size_t                  i, r=1;

        while ( t >= 10 ) {
                t /= 10;
                r++;
        }

        if (s == 0)
                return r;

        for (i = r; i != 0; i--) {
                s[i-1] = (char)(x % 10) + '0';
                x /= 10;
        }

        s[r] = (char)0;
        return r;
}

int writeconsolestr(const char* buf)
{
	return printf("%s", buf);
}

int writelogentry(PFTPCONTEXT context, const char *logtext1, const char *logtext2)
{
	char		cvbuf[32], _text[512];
	time_t		itm = time(NULL);
	struct tm	ltm;

	localtime_r(&itm, &ltm);

	_text[0] = 0;

	if ( ltm.tm_mday < 10 )
		strcat(_text, "0");
	ultostr(ltm.tm_mday, cvbuf);
	strcat(_text, cvbuf);
	strcat(_text, "-");

	if ( ltm.tm_mon+1 < 10 )
		strcat(_text, "0");
	ultostr(ltm.tm_mon+1, cvbuf);
	strcat(_text, cvbuf);
	strcat(_text, "-");

	ultostr(ltm.tm_year+1900, cvbuf);
	strcat(_text, cvbuf);
	strcat(_text, " ");

	if ( ltm.tm_hour < 10 )
		strcat(_text, "0");
	ultostr(ltm.tm_hour, cvbuf);
	strcat(_text, cvbuf);
	strcat(_text, ":");

	if ( ltm.tm_min < 10 )
		strcat(_text, "0");
	ultostr(ltm.tm_min, cvbuf);
	strcat(_text, cvbuf);
	strcat(_text, ":");

	if ( ltm.tm_sec < 10 )
		strcat(_text, "0");
	ultostr(ltm.tm_sec, cvbuf);
	strcat(_text, cvbuf);

	if (context) {
		strcat(_text, " S-id=");
		ultostr(context->SessionID, cvbuf);
		strcat(_text, cvbuf);
	}
	strcat(_text, ": ");

	if (logtext1)
		strcat(_text, logtext1);

	if (logtext2)
		strcat(_text, logtext2);

	strcat(_text, CRLF);

	return writeconsolestr(_text);
}

int main(void)
{
	PFTPCONTEXT context = { 0 };
	char loga[256], logb[256];
	printf("filling buffers\n");
	memset(loga, 'A', 256);
	memset(logb, 'B', 256);
	loga[255] = 0;
	logb[255] = 0;
	printf("calling function\n");
	writelogentry(context, loga, logb);
}
