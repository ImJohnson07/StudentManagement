<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.studentApp.dto.Student"%>
<%!
String esc(String v){return v==null?"":v.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;");}
%>
<%
Student s=(Student)session.getAttribute("student");
if(s==null){response.sendRedirect("login.jsp");return;}
String sname=s.getSname()!=null?s.getSname():"";
String branch=s.getBranch()!=null?s.getBranch():"";
String location=s.getLocation()!=null?s.getLocation():"";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Update page</title>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700&family=Nunito:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#1e2a5a;--bg2:#3b2f7a;--card:#fff;--ink:#1e2a5a;--muted:#6b7394;--accent:#ff8a3d;--line:#dfe3f3;--body:#8fd3ff}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:'Nunito',system-ui,sans-serif;background:radial-gradient(circle at 20% 10%,var(--bg2),var(--bg));display:flex;align-items:center;justify-content:center;padding:24px;color:var(--ink)}
.stage{width:100%;max-width:400px;perspective:1200px}
.tilt{transition:transform .15s ease-out}
.mascot{display:block;width:150px;height:140px;margin:0 auto -30px;position:relative;z-index:2;overflow:visible}
.card{background:var(--card);border-radius:22px;padding:44px 26px 22px;box-shadow:0 30px 60px rgba(0,0,0,.35);animation:rise .7s cubic-bezier(.2,1,.3,1) both}
@keyframes rise{from{opacity:0;transform:translateY(40px) rotateX(18deg)}to{opacity:1;transform:none}}
h1{font-family:'Baloo 2',sans-serif;font-size:28px;margin:0 0 2px;text-align:center}
p.sub{margin:0 0 6px;text-align:center;color:var(--muted);font-size:14px}
label{display:block;font-size:13px;font-weight:600;margin:12px 0 4px}
input[type=text]{width:100%;padding:11px 12px;border:2px solid var(--line);border-radius:12px;font:inherit;color:var(--ink);background:#fff;transition:border-color .2s,transform .2s}
input:focus{outline:none;border-color:var(--accent);transform:scale(1.02)}
.msg{padding:10px 12px;border-radius:12px;font-size:14px;font-weight:600;margin:10px 0 0;text-align:center}
.err{background:#ffe1e6;color:#b3202f}
.ok{background:#d9f6e6;color:#0f7a41}
input[type=submit]{width:100%;margin-top:18px;padding:12px;border:0;border-radius:12px;background:var(--accent);color:#fff;font:700 17px 'Baloo 2',sans-serif;cursor:pointer;box-shadow:0 6px 0 #d96a1f;transition:transform .1s,box-shadow .1s,opacity .2s}
input[type=submit]:disabled{opacity:.45;cursor:not-allowed;box-shadow:0 6px 0 #d96a1f}
input[type=submit]:not(:disabled):active{transform:translateY(4px);box-shadow:0 2px 0 #d96a1f}
input[type=submit]:focus-visible,a:focus-visible{outline:3px solid var(--ink);outline-offset:2px}
.hint{text-align:center;font-size:12px;color:var(--muted);margin-top:8px;min-height:16px}
a.back{display:block;text-align:center;margin-top:12px;font-size:14px;font-weight:700;color:var(--ink)}
.shake{animation:shake .5s}
@keyframes shake{20%{transform:translateX(-10px)}40%{transform:translateX(10px)}60%{transform:translateX(-6px)}80%{transform:translateX(6px)}}
@media (prefers-reduced-motion:reduce){.card,.shake{animation:none}.tilt{transition:none}}
</style>
</head>
<body>
<div class="stage"><div class="tilt" id="tilt">
<svg class="mascot" id="m" viewBox="0 -10 170 160" aria-hidden="true">
<ellipse cx="85" cy="138" rx="50" ry="8" fill="rgba(0,0,0,.2)"/>
<path d="M40 130 Q85 20 130 130Z" fill="var(--body)"/>
<circle cx="85" cy="78" r="52" fill="var(--body)"/>
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
<path id="mouth" d="M70 106 Q85 114 100 106" stroke="#1e2a5a" stroke-width="4" fill="none" stroke-linecap="round"/>
</svg>
<div class="card" id="card">
<h1>Update page</h1>
<p class="sub">Keep your details up to date</p>
<%if(request.getAttribute("fail")!=null){ %>
<div class="msg err"><%=request.getAttribute("fail") %></div>
<%} %>
<%if(request.getAttribute("success")!=null){ %>
<div class="msg ok"><%=request.getAttribute("success") %></div>
<%} %>
<form action="update" method="post" id="f">
<label for="name">Name:</label>
<input type="text" id="name" name="name" placeholder="Enter your name" value="<%=esc(sname)%>" required>
<label for="branch">Branch:</label>
<input type="text" id="branch" name="branch" placeholder="Enter your branch" value="<%=esc(branch)%>" required>
<label for="location">Location:</label>
<input type="text" id="location" name="location" placeholder="Enter your location" value="<%=esc(location)%>" required>
<input type="submit" value="Update" id="btn" disabled>
<div class="hint" id="hint">Change a field to enable the Update button</div>
<a class="back" href="dashboard.jsp">Back to Dashboard</a>
</form>
</div>
</div></div>
<script>
const serverFail=<%=request.getAttribute("fail")!=null %>
const serverOk=<%=request.getAttribute("success")!=null %>
const $=id=>document.getElementById(id)
const pl=$('pl'),pr=$('pr'),mouth=$('mouth'),m=$('m'),tilt=$('tilt'),card=$('card'),btn=$('btn')
const fields=[...document.querySelectorAll('input[type=text]')]
const orig=fields.map(i=>i.value)
const mouths={smile:'M70 106 Q85 114 100 106',big:'M66 102 Q85 128 104 102Z',sad:'M70 112 Q85 100 100 112'}
const setMouth=k=>mouth.setAttribute('d',mouths[k])
const look=(dx,dy)=>{pl.setAttribute('cx',65+dx);pl.setAttribute('cy',76+dy);pr.setAttribute('cx',105+dx);pr.setAttribute('cy',76+dy)}
if(serverFail){setMouth('sad');card.classList.add('shake')}
if(serverOk){setMouth('big');m.animate([{transform:'translateY(0)'},{transform:'translateY(-20px)'},{transform:'translateY(0)'}],{duration:500,iterations:2})}
document.addEventListener('mousemove',e=>{
const r=m.getBoundingClientRect()
const cx=r.left+r.width/2,cy=r.top+r.height/2
const a=Math.atan2(e.clientY-cy,e.clientX-cx)
const d=Math.min(6,Math.hypot(e.clientX-cx,e.clientY-cy)/40)
look(Math.cos(a)*d,Math.sin(a)*d)
tilt.style.transform='rotateY('+(e.clientX/innerWidth-.5)*8+'deg) rotateX('+(e.clientY/innerHeight-.5)*-8+'deg)'
})
fields.forEach(i=>{
i.addEventListener('focus',()=>look(0,4))
i.addEventListener('input',()=>{
const changed=fields.some((f,k)=>f.value.trim()!==orig[k])
btn.disabled=!changed
$('hint').textContent=changed?'Looks good, click Update to save':'Change a field to enable the Update button'
setMouth(changed?'big':'smile')
m.animate([{transform:'rotate(0)'},{transform:'rotate(-3deg)'},{transform:'rotate(3deg)'},{transform:'rotate(0)'}],{duration:250})
})
})
$('f').addEventListener('submit',()=>setMouth('big'))
</script>
</body>
</html>
