package com.studentap.serv;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.function.LongUnaryOperator;

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
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")

public class login extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
StudentDao st=new studentDaoImp();
		
		long phone=Long.parseLong(req.getParameter("phone"));
		String password=req.getParameter("pw");
		
		PrintWriter out=resp.getWriter();
		Student s=st.getStudent(phone, password);
	
		HttpSession session=req.getSession(true);
		
		
		if(s!=null) {
			//out.print("login successfull..");
			
			RequestDispatcher rd=req.getRequestDispatcher("dashboard.jsp");
		//	req.setAttribute("student", s);
			session.setAttribute("student", s);
			req.setAttribute("success", "login successfull");
			
			rd.forward(req, resp);
					
			
		}
		else {
		//	out.print("enter valid phone no or password");
			
			RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
			req.setAttribute("fail", "login failed");
			rd.forward(req, resp);
					
		}
	}

}
