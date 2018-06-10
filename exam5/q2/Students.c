// Students.c ... implementation of Students datatype

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include "Students.h"

#define MAXLINE 1024
typedef struct _stu_rec {
	int   id;
	char  name[20];
	int   degree;
	float wam;
} sturec_t;

typedef struct _students {
    int    nstu;
    StuRec recs;
} students_t;

// read text from input (FILE *)
// write sturec_t structs to output (filedesc)
int makeStuFile(char *inFile, char *outFile)
{
	FILE * fp;
	if(!(fp = fopen(inFile, "r"))){
		perror("FAIL to open inFile\n");
		return 	-1;
	}
	int fp2;
	if(!(fp2 = open(outFile, O_CREAT|O_WRONLY, 0644))){
		perror("FAIL to open outFile\n");
		return 	-2;
	}
	char line[MAXLINE];
	sturec_t srec;
	while(fgets(line, MAXLINE, fp) != NULL){
		if(sscanf(line,"%d %s %d %f", &srec.id,srec.name,&srec.degree,&srec.wam) != 4 ){
			return -3;
		}
		else{
			write(fp2, (const void *)&srec, sizeof(sturec_t));
		}
	}
	close(fp2);
	fclose(fp);
	return 0;

    // attempt to open text input file for reading
    // return -1 if can't open
    // attempt to open binary output file for writing
    // return -2 if can't open
    // for each line in the input file {
    //     attempt to extract (id,name,degree,WAM) from it
    //     return -3 if line does not contains these fields
    // }
    // close both files
    // return 0

	return 0;
	// TODO
}

// build a collection of student records from a file descriptor
Students getStudents(int in)
{
    int ns;  // count of #students

	// Make a skeleton Students struct
	Students ss;
	if ((ss = malloc(sizeof (struct _students))) == NULL) {
		fprintf(stderr, "Can't allocate Students\n");
		return NULL;
	}

	// count how many student records
    int stu_size = sizeof(struct _stu_rec);
    sturec_t s;
	ns = 0;
    while (read(in, &s, stu_size) == stu_size) ns++;
    ss->nstu = ns;
    if ((ss->recs = malloc(ns*stu_size)) == NULL) {
		fprintf(stderr, "Can't allocate Students\n");
		free(ss);
		return NULL;
	}

	// read in the records
	lseek(in, 0L, SEEK_SET);
	for (int i = 0; i < ns; i++)
		read(in, &(ss->recs[i]), stu_size);

	close(in);
	return ss;
}

// show a list of student records pointed to by ss
void showStudents(Students ss)
{
	assert(ss != NULL);
	for (int i = 0; i < ss->nstu; i++)
		showStuRec(&(ss->recs[i]));
}

// show one student record pointed to by s
void showStuRec(StuRec s)
{
	printf("%7d %s %4d %0.1f\n", s->id, s->name, s->degree, s->wam);
}
