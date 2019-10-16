# EMPLOYEE SALARY REPORT

PROJECT SUMMARY
This program reads an input file with employee information such as Warehouse ID, Employee ID,
Employee Position, first and last name, hire date, date of the last pay increase and calculates 
their total starting and current salaries. Employee information and their calculated total salaries 
are then printed on an output file as a detailed employee salary report.

RUNNING THE PROGRAM
The program requires a text editor such as Notepad++ or Visual Studio Code for editing, and cygwin terminal to run.
To execute the program, save the input file and the code file in the same folder, open cygwin terminal, 
change the directory to the folder that contains the files, then enter the following commands:

cobc -xo test.exe --std=mf program1.cbl
./test.exe

IDENTIFICATION DIVISION
This division explains the purpose of the program and what is included in the input and output files.

ENVIRONMENT DIVISION
This division contains the CONFIGURATION SECTION and INPUT-OUTPUT SECTION.

      CONFIGURATION SECTION
      This section declares the names of the source computer and object computer.

      INPUT-OUTPUT SECTION
      This section contains the name of the input file and creates and names the output file.

DATA DIVISION
This division contains the FILE SECTION and WORKING-STORAGE SECTION

      FILE SECTION
      This section breaks down the input and output files. RECORD CONTAINS is used to tell the 
      program how many characters each file is expected to contain. Variable names and their lengths 
      are declared here. The. length is shown by PICTURE clauses. The word FILLER is used to 
      represent blank spaces.

      WORKING-STORAGE SECTION
      This section begins with a flag that tells the program to stop running if there is no more data.

      Next, TOTAL-FIELDS declares the variable names TOTALSTARTSALARY and TOTALCURRSALARY and PIC clauses 
      are used to declare their length.

      Finally, REPORT-FIELDS contains PROPER-SPACING for the report fields.

      The Output Area of the WORKING-STORAGE section contains heading titles and the
      components of each heading. 

               HEADING-ONE contains the date, the author's initials, the company name and the page number,
               each separated by spaces. HEADING-TWO contains the title of the report surrounded by spaces.
               HEADING-THREE and HEADING-FOUR contain additional title names separated by spaces.
               The DETAIL-LINE and TOTAL-LINE contain the names of the output variables, their lengths and 
               the formats of the final calculated total salaries.
               
PROCEDURE DIVISION
This division includes the CONTROL-MODULE which tells the program to perform upcoming routines, HSKPING-ROUTINE which opens the input and output files, accepts the date from HEADING-ONE and performs the next routine, HEADING-ROUTINE which takes each heading and writes it to the output file with proper spacing, PROCESS-EMPLOYEE-ROUTINE which tells the programa to read the input file until there is no more data to read and to perform the next routine, TOTAL-SAL-ROUTINE moves the input values to the output file and performs the next routine, WRITE-A-LINE writes the output report after advancing proper spacing, and EOF-ROUTINE moves the total fields to the total lines, moves the correct output to the output file, closes the input and output files, and stops the program from running with STOP RUN.
               


