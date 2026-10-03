<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Signup page</title>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700&family=Nunito:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#1e2a5a;--bg2:#3b2f7a;--card:#fff;--ink:#1e2a5a;--muted:#6b7394;--accent:#ff8a3d;--line:#dfe3f3;--body:#8fd3ff}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:'Nunito',system-ui,sans-serif;background:radial-gradient(circle at 20% 10%,var(--bg2),var(--bg));display:flex;align-items:center;justify-content:center;padding:24px;color:var(--ink)}
.stage{width:100%;max-width:520px;perspective:1200px}
.tilt{transition:transform .15s ease-out}
.mascot{display:block;width:150px;height:132px;margin:0 auto -30px;position:relative;z-index:2;overflow:visible}
.card{background:var(--card);border-radius:22px;padding:44px 26px 22px;box-shadow:0 30px 60px rgba(0,0,0,.35);animation:rise .7s cubic-bezier(.2,1,.3,1) both}
@keyframes rise{from{opacity:0;transform:translateY(40px) rotateX(18deg)}to{opacity:1;transform:none}}
h1{font-family:'Baloo 2',sans-serif;font-size:28px;margin:0 0 2px;text-align:center}
p.sub{margin:0 0 6px;text-align:center;color:var(--muted);font-size:14px}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:0 14px}
@media (max-width:520px){.grid{grid-template-columns:1fr}}
label{display:block;font-size:13px;font-weight:600;margin:12px 0 4px}
input[type=text],input[type=tel],input[type=email],input[type=password]{width:100%;padding:11px 12px;border:2px solid var(--line);border-radius:12px;font:inherit;color:var(--ink);background:#fff;transition:border-color .2s,transform .2s}
input:focus{outline:none;border-color:var(--accent);transform:scale(1.02)}
.full{grid-column:1/-1}
.bar{height:6px;border-radius:6px;background:var(--line);margin-top:8px;overflow:hidden}
.bar i{display:block;height:100%;width:0;background:#e5484d;transition:width .3s,background .3s}
.hint{font-size:12px;color:var(--muted);margin-top:4px;min-height:16px}
.msg{padding:10px 12px;border-radius:12px;font-size:14px;font-weight:600;margin:10px 0 0;text-align:center}
.err{background:#ffe1e6;color:#b3202f}
input[type=submit]{width:100%;margin-top:18px;padding:12px;border:0;border-radius:12px;background:var(--accent);color:#fff;font:700 17px 'Baloo 2',sans-serif;cursor:pointer;box-shadow:0 6px 0 #d96a1f;transition:transform .1s,box-shadow .1s}
input[type=submit]:active{transform:translateY(4px);box-shadow:0 2px 0 #d96a1f}
input[type=submit]:focus-visible,a:focus-visible{outline:3px solid var(--ink);outline-offset:2px}
.login{text-align:center;margin-top:14px;font-size:14px;color:var(--muted)}
.login a{color:var(--ink);font-weight:700}
.shake{animation:shake .5s}
@keyframes shake{20%{transform:translateX(-10px)}40%{transform:translateX(10px)}60%{transform:translateX(-6px)}80%{transform:translateX(6px)}}
@media (prefers-reduced-motion:reduce){.card,.shake{animation:none}.tilt,.bar i{transition:none}}
</style>
</head>
<body>
<div class="stage"><div class="tilt" id="tilt">
<svg class="mascot" id="m" viewBox="0 0 170 150" aria-hidden="true">
<ellipse cx="85" cy="138" rx="50" ry="8" fill="rgba(0,0,0,.2)"/>
<path d="M40 130 Q85 20 130 130Z" fill="var(--body)"/>
<circle cx="85" cy="78" r="52" fill="var(--body)"/>
<circle cx="52" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="118" cy="98" r="8" fill="#ffb3c1" opacity=".7"/>
<circle cx="65" cy="72" r="15" fill="#fff"/>
<circle cx="105" cy="72" r="15" fill="#fff"/>
<circle id="pl" cx="65" cy="72" r="7" fill="#1e2a5a"/>
<circle id="pr" cx="105" cy="72" r="7" fill="#1e2a5a"/>
<path id="mouth" d="M70 104 Q85 112 100 104" stroke="#1e2a5a" stroke-width="4" fill="none" stroke-linecap="round"/>
<g id="hl" style="transform:translateY(60px);transition:transform .35s cubic-bezier(.3,1.4,.5,1)"><ellipse cx="60" cy="72" rx="19" ry="16" fill="#5fb8f0" stroke="#1e2a5a" stroke-width="3"/></g>
<g id="hr" style="transform:translateY(60px);transition:transform .35s cubic-bezier(.3,1.4,.5,1)"><ellipse cx="110" cy="72" rx="19" ry="16" fill="#5fb8f0" stroke="#1e2a5a" stroke-width="3"/></g>
</svg>
<div class="card" id="card">
<h1>Signup page</h1>
<p class="sub">Create your student account</p>
<%if(request.getAttribute("fail")!=null){ %>
<div class="msg err"><%=request.getAttribute("fail") %></div>
<%} %>
<form action="signup" method="post" id="f">
<div class="grid">
<div><label for="name">Name:</label>
<input type="text" id="name" name="name" placeholder="Enter your name" required></div>
<div><label for="phone">Phone:</label>
<input type="tel" id="phone" name="phone" placeholder="Enter your phone" pattern="[0-9]{10}" maxlength="10" title="Enter a 10 digit phone number" required></div>
<div class="full"><label for="email">Email:</label>
<input type="email" id="email" name="email" placeholder="Enter your email" required></div>
<div><label for="loc">Location:</label>
<input type="text" id="loc" name="loc" placeholder="Enter your location" required></div>
<div><label for="branch">Branch:</label>
<input type="text" id="branch" name="branch" placeholder="Enter your branch" required></div>
<div class="full"><label for="password">Password:</label>
<input type="password" id="password" name="password" placeholder="Enter password" minlength="6" required>
<div class="bar"><i id="bar"></i></div>
<div class="hint" id="ph"></div></div>
<div class="full"><label for="confirm">Confirm password:</label>
<input type="password" id="confirm" name="confirm" placeholder="confirm password" required>
<div class="hint" id="ch"></div></div>
</div>
<input type="submit" value="Sign up">
<div class="login">Already have an account? <a href="login.jsp">Log in</a></div>
</form>
</div>
</div></div>
<script>
const $=id=>document.getElementById(id)
const pl=$('pl'),pr=$('pr'),hl=$('hl'),hr=$('hr'),mouth=$('mouth'),m=$('m'),tilt=$('tilt'),pw=$('password'),cf=$('confirm')
const mouths={smile:'M70 104 Q85 112 100 104',big:'M66 100 Q85 126 104 100Z',sad:'M70 110 Q85 98 100 110',flat:'M72 106 L98 106'}
const setMouth=k=>mouth.setAttribute('d',mouths[k])
const look=(dx,dy)=>{pl.setAttribute('cx',65+dx);pl.setAttribute('cy',72+dy);pr.setAttribute('cx',105+dx);pr.setAttribute('cy',72+dy)}
const cover=on=>{hl.style.transform=hr.style.transform=on?'translateY(0)':'translateY(60px)'}
document.addEventListener('mousemove',e=>{
const r=m.getBoundingClientRect()
const a=Math.atan2(e.clientY-(r.top+r.height/2),e.clientX-(r.left+r.width/2))
const d=Math.min(6,Math.hypot(e.clientX-(r.left+r.width/2),e.clientY-(r.top+r.height/2))/40)
look(Math.cos(a)*d,Math.sin(a)*d)
tilt.style.transform='rotateY('+(e.clientX/innerWidth-.5)*8+'deg) rotateX('+(e.clientY/innerHeight-.5)*-8+'deg)'
})
document.querySelectorAll('input').forEach(i=>{
i.addEventListener('focus',()=>{cover(i.type==='password');if(i.type!=='password')look(0,4)})
i.addEventListener('blur',()=>cover(false))
})
const score=v=>{let s=0;if(v.length>=6)s++;if(v.length>=10)s++;if(/[A-Z]/.test(v)&&/[a-z]/.test(v))s++;if(/\d/.test(v))s++;if(/[^A-Za-z0-9]/.test(v))s++;return s}
pw.addEventListener('input',()=>{
const s=score(pw.value),bar=$('bar')
bar.style.width=s*20+'%'
bar.style.background=s<=2?'#e5484d':s<=3?'#f5a623':'#1a9b55'
setMouth(!pw.value?'smile':s<=1?'sad':s<=3?'flat':'big')
$('ph').textContent=pw.value?(s<=2?'Weak: add capitals, numbers and symbols':s<=3?'Getting there':'Strong password'):''
check()
})
const check=()=>{
if(!cf.value){$('ch').textContent='';return true}
const ok=pw.value===cf.value
$('ch').style.color=ok?'#1a9b55':'#e5484d'
$('ch').textContent=ok?'Passwords match':'Passwords do not match'
setMouth(ok?'big':'sad')
return ok
}
cf.addEventListener('input',check)
$('f').addEventListener('submit',e=>{
if(pw.value!==cf.value){
e.preventDefault()
check()
const c=$('card')
c.classList.remove('shake');void c.offsetWidth;c.classList.add('shake')
cf.focus()
}else{
setMouth('big')
m.animate([{transform:'translateY(0)'},{transform:'translateY(-20px)'},{transform:'translateY(0)'}],{duration:400})
}
})
</script>
</body>
</html>
