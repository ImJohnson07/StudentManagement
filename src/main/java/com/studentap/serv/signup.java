package com.studentap.serv;

import java.io.IOException;
import java.io.PrintWriter;

import com.studentApp.dao.StudentDao;
import com.studentApp.dao.studentDaoImp;
import com.studentApp.dto.Student;

import jakarta.servlet.GenericServlet;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")

public class signup extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
StudentDao st=new studentDaoImp();
		
Student s = new Student();

PrintWriter out=resp.getWriter();

s.setSname(req.getParameter("name"));
s.setPhone(Long.parseLong(req.getParameter("phone")));
s.setEmail(req.getParameter("email"));
s.setLocation(req.getParameter("loc"));
s.setBranch(req.getParameter("branch"));
String password=req.getParameter("password");
String confirm=req.getParameter("confirm");

if(password.equals(confirm)) {
	s.setPassword(password);
	if(st.insertStudent(s)) {
		//out.print("Signup successfully done");
		RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
		req.setAttribute("success", "Woah!Signup Successfully done");
		rd.forward(req, resp);
	} 
	else {
		//out.print("Cannot able to signup");
		RequestDispatcher rd=req.getRequestDispatcher("signup.jsp");
		req.setAttribute("fail", "Sorry!Login failed");
		rd.forward(req, resp);
	}
}
else {
	//out.print("Password Mismatch...");
	RequestDispatcher rd=req.getRequestDispatcher("signup.jsp");
	req.setAttribute("fail", "Sorry!Login failed");
	rd.forward(req, resp);
	
}
}

}
