%{
#include<stdio.h>
#include<stdlib.h>


typedef struct node{
	int row;
	int column;
	struct node *front;
	struct node *next;
}node;

typedef struct headnode{
	unsigned int length;
	struct node *next;
	struct node *first;
	struct node *last;
}headNode;

int yylex();
void add();
void sub();
void mul();
void turn();
struct node *back();
void push_back(int row, int column);
void pop_back();
void yyerror(const char* msg);
struct headnode inputStack;
int flag = 0;
int had = 0;
void yyerror(const char *message);
void colError(int site);
%}

%union {
int 	ival;
int 	sym;
struct mt{
	int row;
	int column;
	} m;
}
%type <m> exp
%token <ival> NUM
%token <sym> '+'
%token <sym> '-'
%token <sym> '*'
%left '+' '-'
%left '*'
%left '^'
%%
line	:	exp					{if (flag==0){ printf("Accepted");}}
		;
exp	:	'[' NUM ',' NUM ']'		{$$.row = $2;$$.column = $4;}
		|	exp '+' exp		{
										if ($1.row==$3.row && $1.column==$3.column){
											$$.row = $1.row;
											$$.column = $1.column ;
										}
										else {
											if (flag==0){
												colError($2);
												flag++;
											}
										}
									}
		|	exp '-' exp		{
										if ($1.row==$3.row && $1.column==$3.column){
											$$.row = $1.row;
											$$.column = $1.column;
										}
										else {
											if (flag==0){
												colError($2);
												flag++;
											}
										}
									}
		|	exp '*' exp		{
										if ($1.column==$3.row){
											$$.row = $1.row;
											$$.column = $3.column;
										}
										else {
											if (flag==0){
												colError($2);
												flag++;
											}
										}
									}
		|	exp '^' 'T'			{$$.row = $1.column; $$.column = $1.row;}
		| 	'(' exp ')'			{$$.row = $2.row; $$.column = $2.column;}
		;
%%
void colError(int col){
	printf("Semantic error on col %d\n", col);
}
void yyerror (const char *msg)
{
    fprintf (stderr, "%s\n",msg);
}


void push_back(int row, int column)
{
	struct node *tmp = malloc(sizeof(struct node));
	tmp->row = row;
	tmp->column = column;
	if(inputStack.length == 0)
	{
		tmp->front = NULL;
		tmp->next = NULL;
		inputStack.last = tmp;
		//printf("%d %d",tmp->row, tmp->column);
	}
	else
	{
		tmp->front = inputStack.last;
		inputStack.last->next = tmp;
		inputStack.last = tmp;
		//printf("%d %d",tmp->row, tmp->column);
	}
	inputStack.length++;
}

void pop_back()
{
	if(inputStack.length>1)
		{
			inputStack.last = inputStack.last->front;
			inputStack.last->next = NULL;
			inputStack.length--;
		}
		else if(inputStack.length == 1)
		{
			inputStack.last = NULL;
			inputStack.length--;
		}
}

struct node *back()
{
	return inputStack.last;
} 

void turn()
{
	int tmp1 = back()->row;
	int tmp2 = back()->column;
	struct node *tmp  = back();
	tmp->row = tmp2;
	tmp->column = tmp1;
	//printf("%d %d",tmp->row, tmp->column);

}

void add()
{
	struct node *tmp1 = back();
	struct node *tmp2 = back()->front;

	if(tmp1->row == tmp2->row && tmp1->column == tmp2->column)
	{
		pop_back();
	}
	else
	{
		flag = 1;
	}
}

void sub()
{
	struct node *tmp1 = back();
	struct node *tmp2 = back()->front;

	if(tmp1->row == tmp2->row && tmp1->column == tmp2->column)
	{
		pop_back();
	}
	else
	{
		flag = 1;
	}
}

void mul()
{
	struct node tmp1 = *back();
	struct node tmp2 = *back()->front;
	//printf("%d %d %d %d\n",tmp2.row , tmp2.column,tmp1.row, tmp1.column);
	if(tmp1.row == tmp2.column)
	{
		pop_back();
		pop_back();
		push_back(tmp2.row,tmp1.column);
	}
	else
	{
		flag = 1;
	}
	
}

int main(int argc, char *argv[]) 
{
        yyparse();
        return(0);
}