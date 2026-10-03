<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.studentApp.dto.Student" %>
<%!
String esc(Object o){String v=o==null?"":String.valueOf(o);return v.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;");}
%>
<%
Student me=(Student)session.getAttribute("student");
if(me==null){response.sendRedirect("login.jsp");return;}
if(me.getSid()!=1){response.sendRedirect("dashboard.jsp");return;}
String sname=me.getSname()!=null?me.getSname():"Admin";
List<Student> list=new ArrayList<Student>();
if(request.getAttribute("stdlist")!=null){
	list=(List<Student>)request.getAttribute("stdlist");
}
Set<String> branches=new HashSet<String>();
Set<String> locations=new HashSet<String>();
for(Student st:list){
	if(st.getBranch()!=null)branches.add(st.getBranch());
	if(st.getLocation()!=null)locations.add(st.getLocation());
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>View students</title>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700&family=Nunito:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#1e2a5a;--bg2:#3b2f7a;--card:#fff;--ink:#1e2a5a;--muted:#6b7394;--accent:#ff8a3d;--line:#dfe3f3;--body:#8fd3ff}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:'Nunito',system-ui,sans-serif;background:radial-gradient(circle at 20% 0%,var(--bg2),var(--bg));color:var(--ink);padding:20px}
.app{max-width:1180px;margin:0 auto;display:grid;grid-template-columns:230px minmax(0,1fr);gap:18px;align-items:start}
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
nav button:focus-visible,nav a:focus-visible,.btn:focus-visible,a:focus-visible,.del:focus-visible{outline:3px solid var(--ink);outline-offset:2px}
.main{background:var(--card);border-radius:22px;padding:24px;box-shadow:0 20px 40px rgba(0,0,0,.3);min-height:420px;min-width:0;animation:in .45s cubic-bezier(.2,1,.3,1)}
@keyframes in{from{opacity:0;transform:translateY(20px) rotateX(10deg)}to{opacity:1;transform:none}}
h1{font-family:'Baloo 2',sans-serif;font-size:26px;margin:0 0 4px}
p.sub{margin:0 0 16px;color:var(--muted);font-size:14px}
.msg{padding:10px 14px;border-radius:12px;background:#d9f6e6;color:#0f7a41;font-weight:600;font-size:14px;margin-bottom:14px}
.chips{display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:12px;margin-bottom:16px;perspective:800px}
.chip{border-radius:16px;padding:12px 14px;background:#eef1ff;transition:transform .2s ease-out}
.chip b{display:block;font:700 28px 'Baloo 2',sans-serif}
.chip span{font-size:13px;color:var(--muted)}
input[type=search]{width:100%;padding:11px 12px;border:2px solid var(--line);border-radius:12px;font:inherit;color:var(--ink);background:#fff;transition:border-color .2s}
input:focus{outline:none;border-color:var(--accent)}
.scroll{overflow-x:auto;margin-top:12px}
table{width:100%;border-collapse:collapse;font-size:14px;min-width:680px}
th,td{text-align:left;padding:10px 8px;border-bottom:1px solid var(--line)}
th{color:var(--muted);font-weight:600}
tbody tr{animation:slide .5s both;transition:background .2s}
tbody tr:hover{background:#f4f6ff}
@keyframes slide{from{opacity:0;transform:translateX(-14px)}to{opacity:1;transform:none}}
.empty{text-align:center;color:var(--muted);padding:16px;display:none}
.empty.on{display:block}
.del{display:inline-block;padding:5px 12px;border-radius:10px;background:#ffe1e6;color:#b3202f;font-weight:700;font-size:13px;text-decoration:none;transition:transform .15s,background .15s}
.del:hover{background:#ffc9d1;transform:scale(1.06)}
.you{color:var(--muted);font-size:13px}
.btn{display:inline-block;margin:14px 4px 0;padding:11px 20px;border:0;border-radius:12px;background:var(--accent);color:#fff;font:700 16px 'Baloo 2',sans-serif;cursor:pointer;box-shadow:0 5px 0 #d96a1f;text-decoration:none;transition:transform .1s,box-shadow .1s}
.btn:active{transform:translateY(3px);box-shadow:0 2px 0 #d96a1f}
.btn.alt{background:#fff;color:var(--ink);box-shadow:0 5px 0 #b9c0e4;border:2px solid var(--line)}
.btn.red{background:#e5484d;box-shadow:0 5px 0 #b3202f}
.modal{position:fixed;inset:0;background:rgba(15,20,50,.6);display:none;align-items:center;justify-content:center;padding:20px;z-index:10}
.modal.on{display:flex}
.box{background:#fff;border-radius:22px;padding:26px;max-width:340px;text-align:center;animation:pop .4s cubic-bezier(.3,1.5,.5,1)}
@keyframes pop{from{transform:scale(.6);opacity:0}to{transform:none;opacity:1}}
.box h2{font-family:'Baloo 2',sans-serif;margin:0 0 6px}
.box p{margin:0;color:var(--muted)}
.wave{transform-origin:135px 110px;animation:wave 1.2s ease-in-out 3}
@keyframes wave{0%,100%{transform:rotate(0)}25%{transform:rotate(-25deg)}75%{transform:rotate(15deg)}}
@media (prefers-reduced-motion:reduce){.main,tbody tr,.box,.wave{animation:none}.chip,nav button,nav a,.del{transition:none}}
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
<a class="on" href="viewstudents" aria-current="page">👥 View students</a>
<a href="profile.jsp">🪪 Profile</a>
<a href="update.jsp">✏️ Update</a>
<a href="dashboard.jsp">🏠 Dashboard</a>
<button class="out" id="logout" type="button">🚪 Logout</button>
</nav>
</aside>
<main class="main">
<h1>View students</h1>
<p class="sub">All registered students</p>
<%if(request.getAttribute("success")!=null){ %>
<div class="msg" role="status"><%=esc(request.getAttribute("success"))%></div>
<%} %>
<div class="chips">
<div class="chip"><b data-to="<%=list.size()%>">0</b><span>Total students</span></div>
<div class="chip"><b data-to="<%=branches.size()%>">0</b><span>Branches</span></div>
<div class="chip"><b data-to="<%=locations.size()%>">0</b><span>Locations</span></div>
</div>
<input type="search" id="q" placeholder="Search by name, phone, email, branch or location" aria-label="Search students">
<div class="scroll"><table>
<thead><tr><th>ID</th><th>Name</th><th>Phone</th><th>Email</th><th>Location</th><th>Branch</th><th>Action</th></tr></thead>
<tbody id="rows">
<%int i=0;
for(Student st:list){ %>
<tr style="animation-delay:<%=Math.min(i,15)*0.05%>s">
<td><%=st.getSid()%></td>
<td><%=esc(st.getSname())%></td>
<td><%=esc(st.getPhone())%></td>
<td><%=esc(st.getEmail())%></td>
<td><%=esc(st.getLocation())%></td>
<td><%=esc(st.getBranch())%></td>
<td>
<%if(st.getSid()==me.getSid()){ %>
<span class="you">You</span>
<%}else{ %>
<a class="del" href="<%=request.getContextPath()%>/delete?Sid=<%=st.getSid()%>" data-name="<%=esc(st.getSname())%>">Delete</a>
<%} %>
</td>
</tr>
<%i++;
} %>
</tbody>
</table></div>
<div class="empty<%=list.isEmpty()?" on":""%>" id="empty">No students found</div>
</main>
</div>
<div class="modal" id="modal" role="dialog" aria-modal="true" aria-labelledby="mt">
<div class="box">
<h2 id="mt">Leaving already?</h2>
<p>Are you sure you want to log out?</p>
<a class="btn" id="yes" href="logout">Yes, log out</a>
<button class="btn alt" id="stay" type="button">Stay</button>
</div>
</div>
<script>
const $=id=>document.getElementById(id)
const all=[...$('rows').querySelectorAll('tr')]
$('q').addEventListener('input',e=>{
const v=e.target.value.toLowerCase()
let n=0
all.forEach(r=>{const hit=r.textContent.toLowerCase().includes(v);r.style.display=hit?'':'none';if(hit)n++})
$('empty').classList.toggle('on',n===0)
})
document.querySelectorAll('[data-to]').forEach(el=>{
const to=parseInt(el.dataset.to),t0=performance.now()
const step=t=>{const p=Math.min(1,(t-t0)/1000);el.textContent=Math.round(to*(1-Math.pow(1-p,3)));if(p<1)requestAnimationFrame(step)}
requestAnimationFrame(step)
})
document.querySelectorAll('.chip').forEach(c=>{
c.addEventListener('mousemove',e=>{const r=c.getBoundingClientRect(),x=(e.clientX-r.left)/r.width-.5,y=(e.clientY-r.top)/r.height-.5;c.style.transform='rotateY('+x*24+'deg) rotateX('+-y*24+'deg)'})
c.addEventListener('mouseleave',()=>{c.style.transform=''})
})
const pl=$('pl'),pr=$('pr')
document.addEventListener('mousemove',e=>{
const a=Math.atan2(e.clientY-120,e.clientX-90)
pl.setAttribute('cx',65+Math.cos(a)*5);pl.setAttribute('cy',72+Math.sin(a)*5)
pr.setAttribute('cx',105+Math.cos(a)*5);pr.setAttribute('cy',72+Math.sin(a)*5)
})
const modal=$('modal')
const open=(title,text,href,label,red)=>{
$('mt').textContent=title
modal.querySelector('p').textContent=text
const y=$('yes')
y.href=href
y.textContent=label
y.classList.toggle('red',red)
modal.classList.add('on')
$('stay').focus()
}
$('logout').onclick=()=>open('Leaving already?','Are you sure you want to log out?','logout','Yes, log out',false)
document.querySelectorAll('.del').forEach(a=>a.addEventListener('click',e=>{
e.preventDefault()
open('Delete student?','This will permanently remove '+a.dataset.name+'.',a.getAttribute('href'),'Yes, delete',true)
}))
$('stay').onclick=()=>modal.classList.remove('on')
modal.addEventListener('click',e=>{if(e.target===modal)modal.classList.remove('on')})
document.addEventListener('keydown',e=>{if(e.key==='Escape')modal.classList.remove('on')})
</script>
</body>
</html>
