package com.studentap.serv;

import java.io.IOException;
import java.io.PrintWriter;

import com.studentApp.dao.StudentDao;
import com.studentApp.dao.studentDaoImp;
import com.studentApp.dto.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgotpassword")
public class forgot extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudentDao st = new studentDaoImp();

		String email = req.getParameter("email");
		long phone = Long.parseLong(req.getParameter("phone"));
		Student s = st.getStudent(email, phone);
		PrintWriter out = resp.getWriter();

		if (s != null) {
			if (req.getParameter("password").equals(req.getParameter("confirm"))) {
				if (s.getPassword().equals(req.getParameter("confirm"))) {
				 //	out.print("This password is already been exist");
					RequestDispatcher rd=req.getRequestDispatcher("forgotpassword.jsp");
					req.setAttribute("fail", "password already exist");
				} else {
					s.setPassword(req.getParameter("confirm"));
					if (st.updateStudent(s)) {
						//out.print("Password Updated");login page
						RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
						req.setAttribute("success", "congrats password updated  ");
						rd.forward(req, resp);
						
						
					} else {
						//out.print("Some issue in password");
						RequestDispatcher rd=req.getRequestDispatcher("forgotpassword.jsp");
						req.setAttribute("fail", " sorry There may be issue in the password,pls check");
						rd.forward(req, resp);
						
					}
				}
			} else {
				//out.print("Password Mismatch");
				RequestDispatcher rd=req.getRequestDispatcher("forgotpassword.jsp");
				req.setAttribute("fail", "pls check bcs there is a passsword mismatch");
				rd.forward(req, resp);
				
			}
		} else {
			//out.print("No student present within the credentials");
			RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
			req.setAttribute("fail", "sorry! there is no student present within these credentials");
			rd.forward(req, resp);
		}
	}
}