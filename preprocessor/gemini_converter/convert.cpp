// Author : Joseph Wonsil
#include <bits/stdc++.h>
#include <unistd.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>

using namespace std;

typedef unsigned int uint;

//These functions are used to (more) efficently count lines of large files
//The next three functions (FileRead, CountLines, and countFileLines) are thanks to anon on StackOverflow
//https://stackoverflow.com/questions/843154/fastest-way-to-find-the-number-of-lines-in-a-text-c
//Accessed September 13, 2019.
unsigned int FileRead( istream & is, vector <char> & buff ) {
    is.read( &buff[0], buff.size() );
    return is.gcount();
}

unsigned int CountLines( const vector <char> & buff, int sz ) {
    int newlines = 0;
    const char * p = &buff[0];
    for ( int i = 0; i < sz; i++ ) {
        if ( p[i] == '\n' ) {
            newlines++;
        }
    }
    return newlines;
}

unsigned int countFileLines(string fileName)
{
        const int SZ = 1024 * 1024;
        std::vector <char> buff( SZ );
        ifstream ifs( fileName );
        int n = 0;
        while( int cc = FileRead( ifs, buff ) ) {
            n += CountLines( buff, cc );
        }
        return(n);
}


void display_usage()
{
	printf("Converts tab-delimited graph txt files to binary. \n");
	printf("Graph txt files are a common SNAP format, binary is used for the Gemini graph processer.\n\n");
	printf("-f [TXT FILE] 	this option specifies the text file to use. This is required.\n");
	printf("-o [FILE] 	this option specifies a binary output filename. Name is binedgelist if not specified.\n");
	printf("-v	 	Runs the converter in verbose mode.\n");
	printf("-h	 	display this dialog.\n");
    printf("-y      Automatic yes to conversion question.\n");
	exit(0);
}

char filePath[100] = "";
char binFile[100] = "";


int line = -1;
uint maxV = 0;


int main(int argc, char * argv[])
{
    int returnValue = 0;
    int c;
    bool isVerbose = false;
    bool autoYes = false;

    while(( c = getopt(argc, argv, "f:o:vhy")) != -1)
    {
	switch(c)
	{
		case 'v':
			isVerbose = true;
			break;
		case 'f':
			strcpy(filePath, optarg);
			break;
		case 'o':
			strcpy(binFile, optarg);
			break;
        case 'y':
            autoYes = true;
            break;
		case 'h':
		case '?':
			display_usage();
			break;
		default:
			printf("enter a file name to convert, and a new name to convert to. \n");
	}

    }
    
    if(filePath[0] == '\0')
    {
    	printf("Please enter a filename\n\n");
        display_usage();
    } else {
        printf("Starting to count lines...\n");
        line = countFileLines(string(filePath));
        printf("Lines counted.\n");
    }
    if(line == -1)
    {
        returnValue = 1;    
    }

    if(binFile[0] == '\0')
    {
	    strcpy(binFile, "binedgelist");
    }

    if(returnValue == 0)
    {
        printf("The program is ready for conversion with the following parameters:\n");
        printf("Text file: %s\n", filePath);
        printf("Output file: %s\n", binFile);
        printf("Number of lines: %d\n", line);
        printf("Verbose mode: %s\n", (isVerbose ? "On" : "Off"));
        if (!autoYes) {
            printf("Continue? (y/n)\n");
            string input;
            cin >> input;
            if (input != "y")
            {
              exit(1);
            }
        }

    	FILE* re = fopen(filePath, "r");
    	FILE* wr = fopen(binFile, "wb+");
    	int i;
    	uint src, dst;
    	printf("Starting conversion...\n");
    	    for(i = 0; i < line; i++) {
            	fscanf(re, "%u %u", &src, &dst);
            	maxV = max(maxV, src);
            	maxV = max(maxV, dst);
            	fwrite(&src, sizeof(src), 1, wr);
            	fwrite(&dst, sizeof(dst), 1, wr);
		    if(isVerbose)
		    {
                printf("%u %u\n", src, dst);
		    }
    	}
    	printf("Finished\n");
    	fclose(re);
    	fclose(wr);
    }

}


