package com.studentApp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.studentApp.conn.connect;
import com.studentApp.dto.Student;

public class studentDaoImp implements StudentDao {
	
	Connection con=null;
	@Override
	public Student getStudent(long phone, String password) {
		// TODO Auto-generated method stub
		String query="SELECT * FROM STUDENT WHERE PHONE=? AND PASSWORD=?";
		PreparedStatement ps=null;
		Student s=null;
		try {
			ps=con.prepareStatement(query);
			ps.setLong(1, phone);
			ps.setString(2, password);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				s=new Student();
				//int id=rs.getInt("sid");
				//s.setSid(id);
				s.setSid(rs.getInt("sid"));
				s.setSname(rs.getString("sname"));
				s.setPhone(rs.getLong("phone"));
				s.setBranch(rs.getString("branch"));
				s.setEmail(rs.getString("email"));
				s.setLocation(rs.getString("location"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;
	
	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return super.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		return super.equals(obj);
	}

	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}

	@Override
	protected void finalize() throws Throwable {
		// TODO Auto-generated method stub
		super.finalize();
	}

	public studentDaoImp() {
		con=connect.getConn();
	}

	@Override
	public boolean insertStudent(Student s) {
		// TODO Auto-generated method stub
		String query="INSERT INTO STUDENT VALUES(0,?,?,?,?,?,?,SYSDATE())";
		PreparedStatement ps=null;
		int res=0;
		try {
			
			ps=con.prepareStatement(query); 
	//		String name=s.getSname();
		//	ps.setString(1, name);
			
			ps.setString(1,s.getSname());
			ps.setLong(2, s.getPhone());
			ps.setString(3,s.getEmail());
			ps.setString(4, s.getBranch());
			ps.setString(5, s.getLocation());
			ps.setString(6, s.getPassword());
			
			res=ps.executeUpdate();
		}
		catch(SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(res>0)
			return true;
		else
			return false;
		
	}
	

	@Override
	public boolean updateStudent(Student s) {
		// TODO Auto-generated method stub
		
		String query="UPDATE STUDENT SET SNAME=?,EMAIL=?,PHONE=?,BRANCH=?,LOCATION=?,PASSWORD=? WHERE SID=?";
		PreparedStatement ps=null;
		int res=0;
		try {
			ps=con.prepareStatement(query);
			ps.setString(1, s.getSname());
			ps.setString(2, s.getEmail());
			ps.setLong(3, s.getPhone());
			ps.setString(4, s.getBranch());
			ps.setString(5, s.getLocation());
			ps.setString(6, s.getPassword());
			ps.setInt(7, s.getSid());
			
			res=ps.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			
		}
		return res>0;
	}

	@Override 
	public boolean deleteStudent(Student s) {
		// TODO Auto-generated method stub
		String query="DELETE FROM STUDENT WHERE SID=? AND SID!=1";
		PreparedStatement ps=null;
		int res=0;
		
		
		try {
			ps=con.prepareStatement(query);
			ps.setInt(1,s.getSid());
			
			res=ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(res>0) {
			return true;
		}
		else
			return false;
		
		}
		
		
	

	@Override
	public Student getStudent(String email, String password) {
		// TODO Auto-generated method stub
		String query="SELECT*FROM STUDENT WHERE EMAIL=? AND PASSWORD=?";
		PreparedStatement ps=null;
		Student s=null;
		try {
			ps=con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				s=new Student();
		//		int id=rs.getInt("sid");
		// 		s.setSid(id);
				
				s.setSid(rs.getInt("sid"));
				s.setSname(rs.getString("sname"));
				s.setPhone(rs.getLong("phone"));
				s.setEmail(rs.getString("email"));
				s.setBranch(rs.getString("branch"));
				s.setLocation(rs.getString("location"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
				
			}	
			}catch (SQLException e) {
				//TODO Auto-generated catch block
				e.printStackTrace();
			}
			return s;
		
	}

	@Override
	public Student getStudent(String email, long phone) {
		// TODO Auto-generated method stub
		String query="SELECT*FROM STUDENT WHERE EMAIL=? AND PHONE=?";
		PreparedStatement ps=null;
		Student s=null;
		try {
			ps=con.prepareStatement(query);
			ps.setString(1, email);
			ps.setLong(2, phone);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				s=new Student();
				s.setSid(rs.getInt("sid"));
				s.setSname(rs.getString("sname"));
				s.setPhone(rs.getLong("phone"));
				s.setEmail(rs.getString("email"));
				s.setBranch(rs.getString("branch"));
				s.setLocation(rs.getString("location"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;
	}

	@Override
	public ArrayList<Student>getStudent() {
		// TODO Auto-generated method stub
		
		ArrayList<Student> list=new ArrayList<Student>();
		
		String query="SELECT*FROM STUDENT";
		PreparedStatement ps=null;
		Student s=null;
		
		try {
			ps=con.prepareStatement(query);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				s=new Student();
				s.setSid(rs.getInt("sid"));
				s.setSname(rs.getString("sname"));
				s.setPhone(rs.getLong("phone"));
				s.setEmail(rs.getString("email"));
				s.setBranch(rs.getString("branch"));
				s.setLocation(rs.getString("location"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
				list.add(s);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
	}

}
