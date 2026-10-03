package com.studentap.serv;

import java.io.IOException;

import com.studentApp.dao.StudentDao;
import com.studentApp.dao.studentDaoImp;
import com.studentApp.dto.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class delete extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int id=Integer.parseInt(req.getParameter("Sid"));
		
		Student s1=new Student();
		s1.setSid(id);
		
		StudentDao st=new studentDaoImp();
		
		if(st.deleteStudent(s1)) {
		//RequestDispatcher rd=req.getRequestDispatcher("viewstudents.jsp");
		//req.setAttribute("success", "deleted successfully");
		
			resp.sendRedirect("viewstudents?success=deleted successfully");
		
	}
		else {
			
			RequestDispatcher rd=req.getRequestDispatcher("viewstudents.jsp");
			req.setAttribute("fail", "something went wrong pls check!");
			rd.forward(req, resp);
		}
	

	}
}
