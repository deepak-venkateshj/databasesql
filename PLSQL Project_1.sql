DECLARE
cursor student_view(p_semester_year numeric,p_semester_term varchar) is
select se.semester_year,se.semester_term,s.section_id,e.student_no,st.enroll_date
from gl_semesters se
JOIN gl_sections s ON se.semester_id=s.semester_id
join gl_enrollments e on s.section_id=e.section_id
join gl_students st on e.student_no=st.student_no
WHERE semester_year=p_semester_year and semester_term=p_semester_term and letter_grade is null and numeric_grade is null;
v_semester_year numeric(20) :=:Enter_Semester_Year;
v_semester_term varchar(1) :=:Enter_Semester_Term;
v_err_msg varchar(200):=' ';
v_current_month numeric(2);
v_current_date DATE default SYSDATE;
v_student_rec student_view%ROWTYPE;


BEGIN
IF v_semester_term IS null OR v_semester_year IS null
THEN 
v_err_msg:='You have not specified both year and term. The lisitings shows missing grades for the current term';
v_current_month:=EXTRACT(month from v_current_date);
v_semester_year:=EXTRACT(year from v_current_date);

IF (v_current_month>=1 AND v_current_month<=4) then
v_semester_term:='W';
ELSIF(v_current_month>=5 AND v_current_month<=8) then
v_semester_term:='S';
ELSIF(v_current_month>=9 and v_current_month<=12) then
v_semester_term:='F';
END IF;

END IF;

DBMS_OUTPUT.PUT_LINE('Enrollment Missing Grade Verification'); 
DBMS_OUTPUT.PUT_LINE('--------------------------------------');
DBMS_OUTPUT.PUT_LINE('                                      ');
DBMS_OUTPUT.PUT_LINE('                                      ');
DBMS_OUTPUT.PUT_LINE(v_err_msg);
DBMS_OUTPUT.PUT_LINE('Year: '||v_semester_year||' Term: '||v_semester_term);
DBMS_OUTPUT.PUT_LINE('                                      ');
DBMS_OUTPUT.PUT_LINE('Section'||chr(9)||'Student No'||chr(9)||'Enroll Date');
DBMS_OUTPUT.PUT_LINE('-------'||chr(9)||'--------'||chr(9)||'------------');

FOR v_student_rec IN student_view(v_semester_year,v_semester_term)
LOOP
EXIT WHEN student_view%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_student_rec.section_id ||chr(9)||v_student_rec.student_no||chr(9)||chr(9)||v_student_rec.enroll_date);

END LOOP;

IF student_view%ROWCOUNT=0 then
RAISE NO_DATA_FOUND;
END IF;

EXCEPTION 
WHEN OTHERS then
DBMS_OUTPUT.PUT_LINE(' ');

END;



