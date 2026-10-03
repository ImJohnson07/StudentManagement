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
import jakarta.servlet.http.HttpSession;

@WebServlet("/update")

public class update extends HttpServlet {
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudentDao st=new studentDaoImp();
		HttpSession session=req.getSession(false);
		Student s=(Student)session.getAttribute("student");
		
		s.setSname(req.getParameter("name"));
		s.setBranch(req.getParameter("branch"));
		s.setLocation(req.getParameter("location"));
		
		if(st.updateStudent(s)) {
			RequestDispatcher rd=req.getRequestDispatcher("dashboard.jsp");
			req.setAttribute("success","update successfully" );
			rd.forward(req, resp);
		}
		else { 
			RequestDispatcher rd=req.getRequestDispatcher("update.jsp");
			req.setAttribute("fail","sorry update failed!" );
			rd.forward(req, resp);
			
			
		}
		
	}

}
