<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentApp.dto.Student" %>
<%!
String esc(String v){return v==null?"":v.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;");}
%>
<%
Student s=null;
if(session.getAttribute("student")!=null){
	s=(Student)session.getAttribute("student");
}
if(s==null){response.sendRedirect("login.jsp");return;}
boolean admin=s.getSid()==1;
String sname=s.getSname()!=null?s.getSname():"Student";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700&family=Nunito:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#1e2a5a;--bg2:#3b2f7a;--card:#fff;--ink:#1e2a5a;--muted:#6b7394;--accent:#ff8a3d;--line:#dfe3f3;--body:#8fd3ff}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:'Nunito',system-ui,sans-serif;background:radial-gradient(circle at 20% 0%,var(--bg2),var(--bg));color:var(--ink)}
.navbar{display:flex;align-items:center;gap:12px;padding:12px 24px;background:rgba(255,255,255,.08);backdrop-filter:blur(8px);border-bottom:1px solid rgba(255,255,255,.15);position:sticky;top:0;z-index:5}
.Logo{font:700 22px 'Baloo 2',sans-serif;color:#fff;display:flex;align-items:center;gap:10px}
.Logo small{font:600 12px 'Nunito',sans-serif;background:var(--accent);padding:3px 10px;border-radius:20px}
.sp{flex:1}
.btn{display:inline-block;padding:10px 18px;border:0;border-radius:12px;background:var(--accent);color:#fff;font:700 15px 'Baloo 2',sans-serif;cursor:pointer;text-decoration:none;box-shadow:0 5px 0 #d96a1f;transition:transform .1s,box-shadow .1s}
.btn:active{transform:translateY(3px);box-shadow:0 2px 0 #d96a1f}
.btn.alt{background:#fff;color:var(--ink);box-shadow:0 5px 0 #b9c0e4}
.btn:focus-visible,.tile:focus-visible{outline:3px solid #fff;outline-offset:3px}
.wrap{max-width:900px;margin:0 auto;padding:28px 20px 40px}
.hero{display:flex;align-items:center;gap:18px;color:#fff;margin-bottom:26px;flex-wrap:wrap}
.hero svg{width:130px;height:118px;overflow:visible;flex:none}
.hero h1{font:700 32px 'Baloo 2',sans-serif;margin:0}
.hero p{margin:4px 0 0;color:#c9d0ff}
.tiles{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px;perspective:900px}
.tile{display:block;background:var(--card);border-radius:22px;padding:24px;text-decoration:none;color:var(--ink);box-shadow:0 18px 36px rgba(0,0,0,.3);transition:transform .2s ease-out;transform-style:preserve-3d;animation:rise .6s cubic-bezier(.2,1,.3,1) both}
.tile:nth-child(2){animation-delay:.1s}
.tile:nth-child(3){animation-delay:.2s}
@keyframes rise{from{opacity:0;transform:translateY(40px) rotateX(16deg)}to{opacity:1;transform:none}}
.ico{width:54px;height:54px;border-radius:16px;display:grid;place-items:center;font-size:28px;margin-bottom:12px;transform:translateZ(34px)}
.tile h2{font:700 22px 'Baloo 2',sans-serif;margin:0 0 4px;transform:translateZ(20px)}
.tile p{margin:0;color:var(--muted);font-size:14px}
.modal{position:fixed;inset:0;background:rgba(15,20,50,.6);display:none;align-items:center;justify-content:center;padding:20px;z-index:10}
.modal.on{display:flex}
.box{background:#fff;border-radius:22px;padding:26px;max-width:340px;text-align:center;animation:pop .4s cubic-bezier(.3,1.5,.5,1)}
@keyframes pop{from{transform:scale(.6);opacity:0}to{transform:none;opacity:1}}
.box h2{font-family:'Baloo 2',sans-serif;margin:0 0 6px}
.box p{margin:0 0 4px;color:var(--muted)}
.box .btn{margin:12px 4px 0}
.wave{transform-origin:135px 110px;animation:wave 1.2s ease-in-out 3}
@keyframes wave{0%,100%{transform:rotate(0)}25%{transform:rotate(-25deg)}75%{transform:rotate(15deg)}}
@media (prefers-reduced-motion:reduce){.tile,.box,.wave{animation:none}.tile{transition:none}}
</style>
</head>
<body>
<nav class="navbar">
<div class="Logo">
Welcome <%=esc(sname)%>
<%if(admin){ %><small>Admin</small><%} %>
</div>
<div class="sp"></div>
<button class="btn alt" id="logout" type="button">Logout</button>
</nav>
<div class="wrap">
<div class="hero">
<svg viewBox="0 0 170 150" aria-hidden="true">
<ellipse cx="85" cy="138" rx="50" ry="8" fill="rgba(0,0,0,.2)"/>
<path d="M40 130 Q85 20 130 130Z" fill="#8fd3ff"/>
<circle cx="85" cy="78" r="52" fill="#8fd3ff"/>
<path d="M45 34 85 14 125 34 85 52Z" fill="#1e2a5a"/>
<path d="M62 44v12q23 12 46 0V44" fill="#2d3c80"/>
<path d="M125 34v22" stroke="#ff8a3d" stroke-width="3" stroke-linecap="round"/>
<circle cx="125" cy="58" r="4" fill="#ff8a3d"/>
<circle cx="52" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="118" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="65" cy="76" r="15" fill="#fff"/>
<circle cx="105" cy="76" r="15" fill="#fff"/>
<circle id="pl" cx="65" cy="76" r="7" fill="#1e2a5a"/>
<circle id="pr" cx="105" cy="76" r="7" fill="#1e2a5a"/>
<path d="M66 102 Q85 128 104 102Z" fill="#1e2a5a"/>
<g class="wave"><ellipse cx="142" cy="104" rx="12" ry="18" fill="#5fb8f0" stroke="#1e2a5a" stroke-width="3"/></g>
</svg>
<div>
<h1>Hi, <%=esc(sname)%>!</h1>
<p>What would you like to do today?</p>
</div>
</div>
<div class="tiles">
<%if(admin){ %>
<a class="tile" href="viewstudents">
<div class="ico" style="background:#e3f0ff">👥</div>
<h2>View Student</h2>
<p>See all registered students</p>
</a>
<%} %>
<a class="tile" href="update.jsp">
<div class="ico" style="background:#fff0d6">✏️</div>
<h2>Update</h2>
<p>Edit your name, branch and location</p>
</a>
<a class="tile" href="profile.jsp">
<div class="ico" style="background:#d9f6e6">🪪</div>
<h2>View profile</h2>
<p>Check your account details</p>
</a>
</div>
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
document.querySelectorAll('.tile').forEach(c=>{
c.addEventListener('mousemove',e=>{const r=c.getBoundingClientRect(),x=(e.clientX-r.left)/r.width-.5,y=(e.clientY-r.top)/r.height-.5;c.style.transform='rotateY('+x*18+'deg) rotateX('+-y*18+'deg) translateZ(10px)'})
c.addEventListener('mouseleave',()=>{c.style.transform=''})
})
const pl=$('pl'),pr=$('pr')
document.addEventListener('mousemove',e=>{
const a=Math.atan2(e.clientY-150,e.clientX-110)
pl.setAttribute('cx',65+Math.cos(a)*5);pl.setAttribute('cy',76+Math.sin(a)*5)
pr.setAttribute('cx',105+Math.cos(a)*5);pr.setAttribute('cy',76+Math.sin(a)*5)
})
const modal=$('modal')
$('logout').onclick=()=>{modal.classList.add('on');$('stay').focus()}
$('stay').onclick=()=>modal.classList.remove('on')
modal.addEventListener('click',e=>{if(e.target===modal)modal.classList.remove('on')})
document.addEventListener('keydown',e=>{if(e.key==='Escape')modal.classList.remove('on')})
</script>
</body>
</html>
