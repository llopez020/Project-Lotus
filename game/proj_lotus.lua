-- 2,516 tokens 8,733 chars


function textbox(x,y,w,h,line1,line2,line3)
	rectfill(x,y,x+w,y+h,0)
	rect(x+4,y+4,x+w-4,128-4,7)

	y=y+8
	print(line1,x+8,y,7)
	print(line2,x+8,y+8,7)
	print(line3,x+8,y+8+8,7)
	wait(20)
	while(stat(28,8)==false) do
	end
	wait(10)
	talkcool=20

end

function yesno(x,y,w,h,line1,line2,line3)

 butpos=0
 answer=true	
 rectfill(x,y,x+w,y+h,0)
	rect(x+4,y+4,x+w-4,128-4,7)

 yesnotext(x,y,w,h,"> "..line1,line2,line3)
	while(stat(28,8)==false) do
		 if (stat(28,26) and answer==false) then answer = true yesnotext(x,y,w,h,"> "..line1,line2,line3) end
			if (stat(28,22) and answer==true) then answer = false yesnotext(x,y,w,h,line1,"> "..line2,line3) end
	end
	
	wait(20)
	
	talkcool=20
	return answer

end

function yesnotext(x,y,w,h,line1,line2,line3)
	rectfill(x+6,y+6,x+w-6,128-6,0)
	y=y+8
	print(line1,x+8,y,7)
	print(line2,x+8,y+8,7)
	print(line3,x+8,y+8+8,7)
	
end

-- entities

function createentity(ex,ey,esp,ew,eh,esx,esy,eox,eoy,etyp,eeight,ec)

    sign=rndsign()
    
    e={
    x=ex,
    y=ey,
    sp=esp,
    w=ew,
    h=eh,
    sx=esx,
    sy=esy,
    ox=eox,
    oy=eoy,
    typ=etyp,
    xspd=sign*1,
    yspd=0,
    xdir=sign*0.01,
    ydir=0.10,
    xe = eeight,
    c=ec
    }
    
    return e
    
    end
    
-- gravity

function gravity()

    if (jmp==3) and (dashtmr<10) then 
    mv=false
     if (grav>gravup) then grav-=.25 lk=2 sp=32
     else jmp=2 lk=2
     end
    end
    
    if (jmp==2 or jmp==1) and (dashtmr<10) then 
     prs=0
     mv=false
     if (grav<3) then grav+=.12 sp=32 end
     if (grav>.5 or jmp==1) then lk=1 end
    end 
     
    if (grav>3) then grav=3 end
    
    
    if (hp!=0 and dashtmr<10) then
    if (platinvuln<0 and platcoll(x+1,y+1+grav,13,14)==true and jmp>1) then jmp=1 gnrd=0 lk=1 gravup=grav-1 collided=1 grav=1 lk=1 dash=0 end
    if (platinvuln<0 and platcoll(x+1,y+1+grav,13,14)==true and jmp<2) then jmp=0 grav=3 gnrd=0 dash=0 end
    if (platinvuln<0 and platcoll(x+1,y+1+grav,13,14)==true and platcoll(x+1,y+2,13,14)==false) then y+=1 grnd=0 dash=0 end
    if (platcoll(x+1,y+1+grav,13,14)==false) or (platinvuln>0) then y+=grav else grnd=0 dash=0 end
    if (jmp!=0 and sprcoll(x+3,y+16,10,30,bx+6,by+10,20,18)==true and sw==10 and lk2==1 and bhit>4) then jmp=3 grav=0 gravup=-1.55 prs=0  end
   
    if (y>130) then jmp=3 grav=0 gravup=-4 if (invinc==0 and invuln<0) then hp=hp-1 invuln=60 end platinvuln=50 end
    end
    if (hp==0 and death!=1) then jmp=3 grav=0 gravup=-1.55 death=1 sfx(4) end 
    if (hp==0 and death==1) then y+=grav end
    if (y>300) then 
        coinup=flr((200-bhp)/5) 
        coins+=coinup
        dset(60,coins)
        textbox(0,90,128,60,"gameover!", "+ "..coinup.." coins!", "new coin total: "..coins)
        textbox(0,90,128,60,"try again?", "", "")
        if(yesno(0,90,128,60,"yes","no","")==true) then wait(30) _init() else
        textbox(0,90,128,60,"returning to base...", "", "")
        wait(70)
        load("proj_lotus_room.p8") 
        end
        end
   
end


-- drawplayer

function drawplayer()

    if (jmp==3) then 
     if (grav>gravup) then lk=2 sp=32
     else lk=2
     end
    end
    
    spr(238,bullx,bully,2,2,bulldir,false)
   
    if (dashtmr<=10) then
    if ((hp!=0 and invuln!=48) and (sw>0 or bulltime>190)) then 
     if (sw>5) then 
      if (hitdir==false and lk2==0) then spr(128,x-10-16,y,4,2,hitdir) end
      if (hitdir==true and lk2==0) then spr(128,x+10,y,4,2,hitdir) end
      if (lk2==1 and jmp!=0) then spr(100,x,y+12,2,4,false,true) end
      if (lk2==2) then spr(100,x,y-10-16,2,4,false,false) end
     elseif (sw>0) then  
      if (hitdir==false and lk2==0) then spr(160,x-10-16,y,4,2,hitdir) end
      if (hitdir==true and lk2==0) then spr(160,x+10,y,4,2,hitdir) end
      if (lk2==1 and jmp!=0) then spr(164,x,y+12,2,4,false,true) end
      if (lk2==2) then spr(164,x,y-10-16,2,4,false,false) end
     end
     
     if (lk2==0) then	spr(64,x,y,2,2,dir) end
        if ((sw>0) and ((lk2==2) or (lk2==2 and jmp!=0))) then spr(68,x,y,2,2,hitdir) end
        if ((sw>0) and (lk2==1 and jmp!=0)) then spr(96,x,y,2,2,hitdir) end
        if ((sw>0) and (lk2==1 and jmp==0 and mv==false)) then spr(34,x,y,2,2,dir) end
        if ((sw>0) and (lk2==1 and jmp==0 and mv==true)) then spr(sp,x,y,2,2,dir) end
        if ((sw<1) and (lk2==1 or lk2==2) and bulltime>190) then spr(64,x,y,2,2,dir) end
        
     sw-=.5
    elseif(hp!=0 and invuln!=48) then 
      if (lk2==1 and jmp==0) then sw=0 end
      if (lk==0 or mv==true) then	spr(sp,x,y,2,2,dir) end
         if ((lk==2 and mv==false) or (lk==2 and jmp!=0)) then spr(32,x,y,2,2,dir) end
         if ((lk==1 and mv==false) or (lk==1 and jmp!=0)) then spr(34,x,y,2,2,dir) end
    elseif (hp!=0) then
     spr(98,x,y,2,2,dir)
    end
    else
      spr(36,x,y,2,2,dashdir)
    end
    
    if (hp==0) then spr(98,x,y,2,2,dir) end
   
end


--controls

function controls() 

    mv=false
    lk=0
    ms=stat(34)
    if (hp!=0 and phase!=100) then
     if (stat(28,7) and dashtmr<=10 and platcoll(x+1.6+1,y+1,13,14)==false) then x+=1.6 dir=true mv=true elseif (stat(28,7) and dashtmr<=10 and platinvuln>0) then x+=1.6 dir=true mv=true end
     if (stat(28,4) and dashtmr<=10 and platcoll(x-1.6+1,y+1,13,14)==false) then x-=1.6 dir=false mv=true elseif (stat(28,4) and dashtmr<=10 and platinvuln>0) then x-=1.6 dir=false mv=true end 
     if (dir==false and dashdir==true and dashtmr>0) then dashtmr=0 dash=0 end
     if (dir==false and dashdir==true and dashtmr>0) then dashtmr=0 dash=0 end
     if (stat(28,26)) then lk=2 end
     if (stat(28,22)) then lk=1 end
     if (stat(28,225) and dash==0 and lshft==0 and dashtmr<0) then dash=1 dashtmr=27 dashdir=dir jmp=1 grav=1 gravup=0 end
     if (dashtmr>=10 and dashdir==false and platcoll(x-2.7+1,y+1,13,14)==false) then x-=2.7 elseif (dashtmr>=10 and dashdir==false and platinvuln>0) then x-=2.7 end 
     if (dashtmr>=10 and dashdir==true and platcoll(x+2.7+1,y+1,13,14)==false) then x+=2.7 elseif (dashtmr>=10 and dashdir==true and platinvuln>0) then x+=2.7 end 
     if (stat(28,44) and dashtmr<10 and spce==0 and jmp==0 and prs==0 and grnd==0 and grav==3) then jmp=3 grav=0 grnd=1 gravup=-0.2 lk=2 prs=1 dashtmr=0 dash=0 end
     if (stat(28,44) and jmp==3 and prs==1) then gravup-=.204 end
     if (stat(28,18) and stat(28,12) and invin==0) then if (invinc==1) then invinc=0 else invinc=1 end end
     if ((ms==1 or (stat(28,13) and pj==0)) and (dashtmr<15 and lstms==0 and lsms<0)) then lsms=10 sw=10 lk2=lk hitdir=dir sfx(0) end
     if ((ms==2 or (stat(28,14) and pk==0)) and (dashtmr<15 and bulltime<0)) then bulltime=200 bulldir=dir bullx=x bully=y+1 lk2=lk end
     if (stat(28,225)) then lshft=1 else lshft=0 end 
     if (stat(28,44)) then spce=1 else spce=0 end
     if (stat(28,13)) then pj=1 else pj=0 end 
     if (stat(28,14)) then pk=1 else pk=0 end 
     if (stat(28,18) and stat(28,12)) then invin=1 else invin=0 end

     lsms-=1
     lstms=stat(34)
    end
    
    if (bhit<1 and sprcoll(bullx+2,bully+3,12,10,bx+6,by+10,20,18)==true) then bhp=bhp-2 bhit=5 sfx(1) end
    if (bhit<1 and sprcoll(x+1,y+16,13,30,bx+6,by+10,20,18)==true and sw>5 and lk2==1 and jmp!=0) then bhp=bhp-1 bhit=5 sfx(1) end
    if (bhit<1 and sprcoll(x+1,y-1-26,13,26,bx+6,by+10,20,18)==true and sw>5 and lk2==2) then bhp=bhp-1 bhit=5 sfx(1) end
    if (bhit<1 and sprcoll(x-1-22,y+1,26,13,bx+6,by+10,20,18)==true and sw>0 and lk2==0 and hitdir==false) then bhp=bhp-1 bhit=5 sfx(1) end
    if (bhit<1 and sprcoll(x+16,y+1,26,13,bx+6,by+10,20,18)==true and sw>0 and lk2==0 and hitdir==true) then bhp=bhp-1 bhit=5 sfx(1) end
    if (bhit==5 and diff<2) then bhp=bhp-1 end
    
    if (sw>0 and lk2==1 and jmp!=0) then showhitbox(x+1,y+16,x+3+11,y+16+24,8)end
    if (sw>0 and lk2==2) then showhitbox(x+1,y-1,x,y-1-22,8) end
    if (sw>0 and lk2==0 and hitdir==false) then showhitbox(x-1,y+1,x-1-22,y+4+10,8) end
    if (sw>0 and lk2==0 and hitdir==true) then showhitbox(x+16,y+1,x+16+22,y+4+10,8) end
   
    bhit=bhit-.3
end


-- collision

function platcoll(x,y,w,h)
   
   col=false
   
    for i=0,platn do
     if (plat[i]!=nil and plat[i].w!=-1) then
      if sprcoll(x,y,w,h,plat[i].x,plat[i].y,plat[i].w,plat[i].h)==true then col=true return col end
     end
    end 
   
   return col
   
end

function coll(x,y,w,h) 

    col=false
   

    for i=x,x+w,w do
     if (fget(mget(i/8,y/8))>0) or (fget(mget(i/8,(y+h)/8))>0) then
      col=true
     end
    end
     
    for i=y,y+h,h do
     if (fget(mget(x/8,i/8))>0) or (fget(mget((x+w)/8,i/8))>0) then
      col=true
     end
    end
   
    return col
    
   end
   
   function sprcoll(x,y,w,h,x2,y2,w2,h2)
   
    col=false
    
    showhitbox(x2,y2,x2+w2,y2+h2,8)
    showhitbox(x,y,x+w,y+h,8)

    if ((x<x2+w2) and (x+w>x2) and (y<y2+h2) and (y+h>y2)) then
     col=true return col
    end
   
    return col
    
end


--load sprites -- from @01010111

function loadsprite()
    for i=1,2 do
      string_to_sprite(a[i%1+1],0,0,128,128)
    end
end

function string_to_sprite(s,x,y,w,h)
    for yy=0,h-1 do
     for xx=0,w-1 do
      local n=0
      local s=sub(s,xx+yy*w+1,xx+yy*w+1)
      if (s=="0") n=0
      if (s=="1") n=1
      if (s=="2") n=2
      if (s=="3") n=3
      if (s=="4") n=4
      if (s=="5") n=5
      if (s=="6") n=6
      if (s=="7") n=7
      if (s=="8") n=8
      if (s=="9") n=9
      if (s=="a") n=10
      if (s=="b") n=11
      if (s=="c") n=12
      if (s=="d") n=13
      if (s=="e") n=14
      if (s=="f") n=15
      sset(x+xx,y+yy,n)
     end
    end
end