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

// build a collection of student records from a file descriptor
Students getStudents(int in)
{
    Students stus = malloc(sizeof(students_t));
    if(stus == NULL){
        perror("Fail to malloc");
        return NULL;    
    }
    stus->nstu = 0;
    off_t total_size = lseek(in, 0, SEEK_END);
    stus->nstu = total_size/(sizeof(sturec_t));
    stus->recs = malloc( stus->nstu * sizeof(sturec_t));
    if(stus->recs  == NULL){
        perror("Fail to malloc");
        return NULL;    
    }
	lseek(in, 0, SEEK_SET);
    int i = 0;
    while(read(in, &(stus->recs[i]) , sizeof(sturec_t)) > 0){
        i++;    
    }
    return stus;
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
