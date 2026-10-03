<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentApp.dto.Student" %>
<%!
String esc(Object o){String v=o==null?"":String.valueOf(o);return v.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;");}
%>
<%
Student s=(Student)session.getAttribute("student");
if(s==null){response.sendRedirect("login.jsp");return;}
boolean admin=s.getSid()==1;
String sname=s.getSname()!=null?s.getSname():"Student";
String initial=sname.length()>0?sname.substring(0,1).toUpperCase():"S";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Profile</title>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700&family=Nunito:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#1e2a5a;--bg2:#3b2f7a;--card:#fff;--ink:#1e2a5a;--muted:#6b7394;--accent:#ff8a3d;--line:#dfe3f3;--body:#8fd3ff}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:'Nunito',system-ui,sans-serif;background:radial-gradient(circle at 20% 0%,var(--bg2),var(--bg));color:var(--ink);padding:20px}
.app{max-width:1040px;margin:0 auto;display:grid;grid-template-columns:230px minmax(0,1fr);gap:18px;align-items:start}
@media (max-width:760px){.app{grid-template-columns:1fr}}
.side{background:var(--card);border-radius:22px;padding:18px;box-shadow:0 20px 40px rgba(0,0,0,.3);position:sticky;top:20px}
@media (max-width:760px){.side{position:static}}
.hero{text-align:center}
.hero svg{width:110px;height:100px;overflow:visible}
.hero h2{font-family:'Baloo 2',sans-serif;margin:0;font-size:20px}
.hero p{margin:0 0 12px;color:var(--muted);font-size:13px}
nav{display:flex;flex-direction:column;gap:8px}
@media (max-width:760px){nav{flex-direction:row;flex-wrap:wrap}nav button,nav a{flex:1 1 40%}}
nav button,nav a{display:flex;align-items:center;gap:10px;width:100%;padding:11px 14px;border:0;border-radius:14px;background:transparent;color:var(--ink);font:700 16px 'Baloo 2',sans-serif;cursor:pointer;text-align:left;text-decoration:none;transition:transform .2s,background .2s}
nav button:hover,nav a:hover{background:#eef1ff;transform:translateX(4px)}
nav .on{background:var(--accent);color:#fff;box-shadow:0 5px 0 #d96a1f}
nav .on:hover{background:var(--accent)}
nav .out{color:#b3202f}
nav .out:hover{background:#ffe1e6}
nav button:focus-visible,nav a:focus-visible,.btn:focus-visible,a:focus-visible{outline:3px solid var(--ink);outline-offset:2px}
.main{background:var(--card);border-radius:22px;padding:24px;box-shadow:0 20px 40px rgba(0,0,0,.3);min-height:420px;min-width:0;animation:in .45s cubic-bezier(.2,1,.3,1)}
@keyframes in{from{opacity:0;transform:translateY(20px) rotateX(10deg)}to{opacity:1;transform:none}}
h1{font-family:'Baloo 2',sans-serif;font-size:26px;margin:0 0 4px}
p.sub{margin:0 0 18px;color:var(--muted);font-size:14px}
.pcard{display:flex;gap:24px;align-items:center;flex-wrap:wrap;perspective:800px}
.av{width:110px;height:110px;border-radius:50%;background:var(--body);display:grid;place-items:center;font:700 46px 'Baloo 2',sans-serif;border:5px solid var(--accent);flex:none;transition:transform .5s}
.av:hover{transform:rotateY(180deg)}
.rows{flex:1;min-width:240px}
.rows div{display:flex;justify-content:space-between;gap:12px;padding:11px 0;border-bottom:1px solid var(--line);font-size:15px;animation:slide .5s both}
.rows div:nth-child(2){animation-delay:.07s}
.rows div:nth-child(3){animation-delay:.14s}
.rows div:nth-child(4){animation-delay:.21s}
.rows div:nth-child(5){animation-delay:.28s}
.rows div:nth-child(6){animation-delay:.35s}
.rows span{color:var(--muted)}
.rows b{text-align:right;word-break:break-word}
@keyframes slide{from{opacity:0;transform:translateX(-14px)}to{opacity:1;transform:none}}
.btn{display:inline-block;margin:20px 4px 0 0;padding:11px 20px;border:0;border-radius:12px;background:var(--accent);color:#fff;font:700 16px 'Baloo 2',sans-serif;cursor:pointer;box-shadow:0 5px 0 #d96a1f;text-decoration:none;transition:transform .1s,box-shadow .1s}
.btn:active{transform:translateY(3px);box-shadow:0 2px 0 #d96a1f}
.btn.alt{background:#fff;color:var(--ink);box-shadow:0 5px 0 #b9c0e4;border:2px solid var(--line)}
.modal{position:fixed;inset:0;background:rgba(15,20,50,.6);display:none;align-items:center;justify-content:center;padding:20px;z-index:10}
.modal.on{display:flex}
.box{background:#fff;border-radius:22px;padding:26px;max-width:340px;text-align:center;animation:pop .4s cubic-bezier(.3,1.5,.5,1)}
@keyframes pop{from{transform:scale(.6);opacity:0}to{transform:none;opacity:1}}
.box h2{font-family:'Baloo 2',sans-serif;margin:0 0 6px}
.box p{margin:0;color:var(--muted)}
.box .btn{margin:14px 4px 0}
.wave{transform-origin:135px 110px;animation:wave 1.2s ease-in-out 3}
@keyframes wave{0%,100%{transform:rotate(0)}25%{transform:rotate(-25deg)}75%{transform:rotate(15deg)}}
@media (prefers-reduced-motion:reduce){.main,.rows div,.box,.wave{animation:none}.av,nav button,nav a{transition:none}}
</style>
</head>
<body>
<div class="app">
<aside class="side">
<div class="hero">
<svg viewBox="0 0 170 150" aria-hidden="true">
<ellipse cx="85" cy="138" rx="50" ry="8" fill="rgba(0,0,0,.2)"/>
<path d="M40 130 Q85 20 130 130Z" fill="#8fd3ff"/>
<circle cx="85" cy="78" r="52" fill="#8fd3ff"/>
<circle cx="52" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="118" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="65" cy="72" r="15" fill="#fff"/>
<circle cx="105" cy="72" r="15" fill="#fff"/>
<circle id="pl" cx="65" cy="72" r="7" fill="#1e2a5a"/>
<circle id="pr" cx="105" cy="72" r="7" fill="#1e2a5a"/>
<path d="M66 100 Q85 126 104 100Z" fill="#1e2a5a"/>
<g class="wave"><ellipse cx="140" cy="100" rx="12" ry="18" fill="#5fb8f0" stroke="#1e2a5a" stroke-width="3"/></g>
</svg>
<h2>Hi, <%=esc(sname)%>!</h2>
<p>Welcome to your dashboard</p>
</div>
<nav aria-label="Dashboard menu">
<%if(admin){ %>
<a href="viewstudents">👥 View students</a>
<%} %>
<a class="on" href="profile.jsp" aria-current="page">🪪 Profile</a>
<a href="update.jsp">✏️ Update</a>
<a href="dashboard.jsp">🏠 Dashboard</a>
<button class="out" id="logout" type="button">🚪 Logout</button>
</nav>
</aside>
<main class="main">
<h1>Profile</h1>
<p class="sub">Your account details</p>
<div class="pcard">
<div class="av"><%=esc(initial)%></div>
<div class="rows">
<div><span>ID</span><b><%=esc(s.getSid())%></b></div>
<div><span>Name</span><b><%=esc(s.getSname())%></b></div>
<div><span>Phone</span><b><%=esc(s.getPhone())%></b></div>
<div><span>Email</span><b><%=esc(s.getEmail())%></b></div>
<div><span>Location</span><b><%=esc(s.getLocation())%></b></div>
<div><span>Branch</span><b><%=esc(s.getBranch())%></b></div>
</div>
</div>
<a class="btn" href="update.jsp">Edit details</a>
<a class="btn alt" href="dashboard.jsp">Back</a>
</main>
</div>
<div class="modal" id="modal" role="dialog" aria-modal="true" aria-labelledby="mt">
<div class="box">
<h2 id="mt">Leaving already?</h2>
<p>Are you sure you want to log out?</p>
<a class="btn" href="logout">Yes, log out</a>
<button class="btn alt" id="stay" type="button">Stay</button>
</div>
</div>
<script>
const $=id=>document.getElementById(id)
const pl=$('pl'),pr=$('pr')
document.addEventListener('mousemove',e=>{
const a=Math.atan2(e.clientY-120,e.clientX-90)
pl.setAttribute('cx',65+Math.cos(a)*5);pl.setAttribute('cy',72+Math.sin(a)*5)
pr.setAttribute('cx',105+Math.cos(a)*5);pr.setAttribute('cy',72+Math.sin(a)*5)
})
const modal=$('modal')
$('logout').onclick=()=>{modal.classList.add('on');$('stay').focus()}
$('stay').onclick=()=>modal.classList.remove('on')
modal.addEventListener('click',e=>{if(e.target===modal)modal.classList.remove('on')})
document.addEventListener('keydown',e=>{if(e.key==='Escape')modal.classList.remove('on')})
</script>
</body>
</html>
