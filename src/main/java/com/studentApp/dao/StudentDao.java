package com.studentApp.dao;

import java.util.ArrayList;

import com.studentApp.dto.Student;

public interface StudentDao {
	public boolean insertStudent(Student s);
	public boolean updateStudent(Student s);
	public boolean deleteStudent(Student s);
	public Student getStudent(String email,String password);
	public Student getStudent(long phone,String password);
	public Student getStudent(String email,long phone);
	public ArrayList<Student> getStudent();
	

}
	