       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROGRAM1.
       AUTHOR. M OWEN.
      ****************************************************************
      * This is a program which produces a DETAILED EMPLOYEE SALARY REPORT
      * REPORT listing employee names, ID numbers, salaries and the date of 
      * their last pay increase.
      * It also calculates the combined starting salaries
      * and the combined current salaries. (S01)
      * ******
      * INPUT:
      *    The EMPLOYEE FILE contains the following
      *    data in each record:
      *         1.  WAREHOUSE ID
      *         2.  EMPLOYEE ID
      *         3.  EMPLOYEE POSITION
      *         4.  EMPLOYEE LAST NAME
      *         5.  EMPLOYEE FIRST NAME
      *         6.  HIRE DATE
      *         7.  STARTING SALARY
      *         8.  DATE OF LAST PAY INCREASE
      *         9.  CURRENT SALARY
      *
      * *******
      * OUTPUT:
      *    The OUTPUT FILE contains the following information:
      *    ************
      *    DETAIL LINE:
      *         1.  WAREHOUSE ID NUMBER
      *         2.  EMPLOYEE ID NUMBER
      *         3.  EMPLOYEE LAST NAME
      *         4.  STARTING SALARY
      *         5.  LAST INCREASE
      *         6.  CURRENT SALARY
      *    *************
      *    FINAL TOTALS:
      *         1. TOTAL OF ALL STARTING SALARIES
      *         2. TOTAL OF ALL CURRENT SALARIES 
      * *************
      * CALCULATIONS:
      *    TOTAL STARTING SALARY
      *        THE SUM OF ALL STARTING SALARIES
      *    TOTAL CURRENT SALARY
      *        THE SUM OF ALL CURRENT SALARIES
      ****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  DESKTOP-CO4BC0K.
       OBJECT-COMPUTER.  DESKTOP-CO4BC0K.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE-FILE
               ASSIGN TO 'PR1FA19.TXT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE
               ASSIGN TO PRINTER 'REPORT-OUT'.
               
       DATA DIVISION.
       FILE SECTION.

       FD  EMPLOYEE-FILE
           RECORD CONTAINS 70 CHARACTERS.

       01  SALARY-RECORD.
           05  WAREHOUSEID-IN          PIC X(4).
           05  EMPLOYEEID-IN           PIC X(5).
           05  EMPLOYEEPOSITION-IN     PIC X(2).
           05  EMPLOYEELN-IN           PIC X(10).
           05  EMPLOYEEFN-IN           PIC X(10).
           05  FILLER                  PIC X(3).
           05  HIRE-DATE               PIC 9(8).
           05  STARTSALARY-IN          PIC 9(6)V9(2).
           05  FILLER                  PIC 9(4).
           05  LASTINCREASE-IN         PIC 9(8).
           05  CURRENTSALARY-IN        PIC 9(6)V9(2).
    

       FD  OUTPUT-FILE
           RECORD CONTAINS 80 CHARACTERS.

       01  REPORT-OUT            PIC X(80).
           

       WORKING-STORAGE SECTION.

       01  FLAGS-N-SWITCHES.
           05  EOF-FLAG                PIC X          VALUE ' '.
               88  NO-MORE-DATA                       VALUE 'N'.

       01  TOTAL-FIELDS.
           05  TF-TOTALSTARTSALARY     PIC S9(6)V9(2) VALUE +0.
           05  TF-TOTALCURRSALARY      PIC S9(6)V9(2) VALUE +0.
           
       01  REPORT-FIELDS.
           05   PROPER-SPACING         PIC S9         VALUE +2.

      **************        OUTPUT AREA        ********************
           
       01  HEADING-ONE.
           05 H1-DATE                  PIC 9999/99/99.
           05                          PIC X(5)      VALUE SPACES.
           05                          PIC X(3)      VALUE 'MRO'.
           05 FILLER                   PIC X(18)     VALUE SPACES.
           05                          PIC X(11)     
                                       VALUE 'DRAKEA, LTD'.
           05                          PIC X(24).
           05                          PIC X(9)      VALUE ' PAGE 01'. 

       01  HEADING-TWO.
           05                          PIC X(35)     VALUE SPACES.
           05                          PIC X(13)     
                                       VALUE "SALARY REPORT".      
           05                          PIC X(31).

       01  HEADING-THREE.
           05                          PIC X(3).
           05                          PIC X(9)      VALUE 'WAREHOUSE'.
           05                          PIC X(3).
           05                          PIC X(8)      VALUE 'EMPLOYEE'.
           05                          PIC X(4).
           05                          PIC X(8)      VALUE 'EMPLOYEE'.
           05                          PIC X(5).
           05                          PIC X(8)      VALUE 'STARTING'.
           05                          PIC X(8).
           05                          PIC X(4)      VALUE 'LAST'.
           05                          PIC X(8).
           05                          PIC X(7)      VALUE 'CURRENT'.
           05                          PIC X(4).
           
       01  HEADING-FOUR.
           05                          PIC X(6).
           05                          PIC X(2)      VALUE 'ID'.
           05                          PIC X(10).
           05                          PIC X(2)      VALUE 'ID'.
           05                          PIC X(6).
           05                          PIC X(9)      VALUE 'LAST NAME'.
           05                          PIC X(6).
           05                          PIC X(6)      VALUE 'SALARY'.
           05                          PIC X(7).
           05                          PIC X(8)      VALUE 'INCREASE'.
           05                          PIC X(6).
           05                          PIC X(6)      VALUE 'SALARY'.
           05                          PIC X(5).
           
       01  DETAIL-LINE.
           05                          PIC X(5)      VALUE SPACES.
           05 WAREHOUSEID-OUT          PIC X(4).     
           05                          PIC X(7).
           05 EMPLOYEEID-OUT           PIC X(5).      
           05                          PIC X(5).
           05 EMPLOYEELN-OUT           PIC X(10)     VALUE SPACES.
           05                          PIC X(2)      VALUE SPACES.
           05 STARTSALARY-OUT          PIC $Z99,999.99.    
           05                          PIC X(3)      VALUE SPACES.
           05 LASTINCREASE-OUT         PIC 99/99/9999.
           05                          PIC X(5)      VALUE SPACES.
           05 TOTALCURRSAL-OUT         PIC $Z99,999.99.
           05                          PIC X(3)      VALUE SPACES.
           


       01  TOTAL-LINE.
           05                          PIC X(31).
           05                          PIC X(6)      VALUE 'TOTAL:'.
           05                          PIC X(1).
           05 TL-TOTALSTARTSALARY      PIC $999,999.99.
           05                          PIC X(18).
           05 TL-TOTALCURRSALARY       PIC $999,999.99.    
           05                          PIC X(2)      VALUE SPACES.           
      /
       PROCEDURE DIVISION.
      *                                MRO
       10-CONTROL-MODULE.
      
       PERFORM 15-HSKPING-ROUTINE
       PERFORM 25-PROCESS-EMPLOYEE-ROUTINE
       PERFORM 40-EOF-ROUTINE
       .
          
       15-HSKPING-ROUTINE.

           OPEN INPUT EMPLOYEE-FILE
               OUTPUT OUTPUT-FILE 
           ACCEPT H1-DATE FROM DATE YYYYMMDD
           PERFORM 20-HEADER-ROUTINE
           .
           
       20-HEADER-ROUTINE.

           WRITE REPORT-OUT FROM HEADING-ONE
               AFTER ADVANCING PROPER-SPACING
           MOVE 2 TO PROPER-SPACING 
           MOVE HEADING-TWO TO REPORT-OUT
           WRITE REPORT-OUT FROM HEADING-TWO
               AFTER ADVANCING PROPER-SPACING
           MOVE 2 TO PROPER-SPACING
           MOVE HEADING-THREE TO REPORT-OUT
           WRITE REPORT-OUT FROM HEADING-THREE
               AFTER ADVANCING PROPER-SPACING
           MOVE 1 TO PROPER-SPACING
           MOVE HEADING-FOUR TO REPORT-OUT
           WRITE REPORT-OUT FROM HEADING-FOUR
               AFTER ADVANCING PROPER-SPACING
           MOVE 2 TO PROPER-SPACING
           .
           
       25-PROCESS-EMPLOYEE-ROUTINE.

           PERFORM UNTIL NO-MORE-DATA
               READ EMPLOYEE-FILE
                   AT END
                       MOVE 'N' TO EOF-FLAG
                   NOT AT END
                       PERFORM 30-TOTAL-SAL-ROUTINE
               END-READ
           END-PERFORM
           .
           
       30-TOTAL-SAL-ROUTINE.
       
           MOVE WAREHOUSEID-IN TO WAREHOUSEID-OUT
           MOVE EMPLOYEEID-IN TO EMPLOYEEID-OUT
           MOVE EMPLOYEELN-IN TO EMPLOYEELN-OUT
           MOVE STARTSALARY-IN TO STARTSALARY-OUT
           MOVE LASTINCREASE-IN TO LASTINCREASE-OUT
           MOVE CURRENTSALARY-IN TO TOTALCURRSAL-OUT
           ADD STARTSALARY-IN, TF-TOTALSTARTSALARY,
               GIVING TF-TOTALSTARTSALARY
           ADD CURRENTSALARY-IN, TF-TOTALCURRSALARY
               GIVING TF-TOTALCURRSALARY
           MOVE DETAIL-LINE TO REPORT-OUT
           PERFORM 35-WRITE-A-LINE
           MOVE 1 TO PROPER-SPACING
           .
           
       35-WRITE-A-LINE.

           WRITE REPORT-OUT
               AFTER ADVANCING PROPER-SPACING
           .
           
       40-EOF-ROUTINE.

           MOVE TF-TOTALSTARTSALARY TO TL-TOTALSTARTSALARY
           MOVE TF-TOTALCURRSALARY TO TL-TOTALCURRSALARY
           MOVE TOTAL-LINE TO REPORT-OUT
           MOVE 2 TO PROPER-SPACING      
           PERFORM 35-WRITE-A-LINE
           CLOSE EMPLOYEE-FILE
               OUTPUT-FILE
           STOP RUN
           .
