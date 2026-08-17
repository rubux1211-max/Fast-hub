local P,CG,TS,RS=game:GetService("Players"),game:GetService("CoreGui"),game:GetService("TweenService"),game:GetService("ReplicatedStorage")
local LP=P.LocalPlayer
local PG=LP:FindFirstChildOfClass("PlayerGui") or CG
if PG:FindFirstChild("FastHub") then PG.FastHub:Destroy() end
local SG=Instance.new("ScreenGui",PG)SG.Name="FastHub"SG.ResetOnSpawn=false
local BG=Color3.fromRGB(10,12,17)local FR=Color3.fromRGB(18,21,28)local AC=Color3.fromRGB(0,255,136)local AC2=Color3.fromRGB(0,230,190)local TX=Color3.fromRGB(240,244,250)local DK=Color3.fromRGB(130,140,155)local OFF=Color3.fromRGB(40,44,54)
local function GRAD(o,c1,c2,rot)local g=Instance.new("UIGradient",o)g.Color=ColorSequence.new(c1,c2)g.Rotation=rot or 90 return g end
local function STK(o,c,t,tr)local s=Instance.new("UIStroke",o)s.Color=c or Color3.new(1,1,1)s.Thickness=t or 1 s.Transparency=tr or 0 return s end
local function COR(o,r)local c=Instance.new("UICorner",o)c.CornerRadius=UDim.new(0,r or 10)return c end
-- ==== LAUNCHER ====
local LOPEN=true
local LFH=Instance.new("Frame",SG)LFH.Size=UDim2.new(0,316,0,356)LFH.Position=UDim2.new(0.5,-158,0.4,-178)LFH.BackgroundColor3=AC LFH.BackgroundTransparency=0.88 LFH.BorderSizePixel=0 LFH.ZIndex=0
COR(LFH,16)STK(LFH,AC,1,0.75)
local LF=Instance.new("Frame",SG)LF.Size=UDim2.new(0,300,0,340)LF.Position=UDim2.new(0.5,-150,0.4,-170)LF.BackgroundColor3=BG LF.BackgroundTransparency=0.35 LF.BorderSizePixel=0 LF.Active=true LF.Draggable=true LF.ZIndex=1
COR(LF,14)STK(LF,AC,1,0.4)GRAD(LF,BG,Color3.fromRGB(16,20,28),90)
local LH=Instance.new("Frame",LF)LH.Size=UDim2.new(1,0,0,40)LH.BackgroundColor3=FR LH.BackgroundTransparency=0.35 LH.BorderSizePixel=0
COR(LH,14)GRAD(LH,Color3.fromRGB(22,26,34),Color3.fromRGB(13,16,22),90)
local LLOGO=Instance.new("Frame",LH)LLOGO.Size=UDim2.new(0,18,0,18)LLOGO.Position=UDim2.new(0,10,0,11)LLOGO.BackgroundColor3=AC COR(LLOGO,9)GRAD(LLOGO,AC,AC2,90)STK(LLOGO,Color3.new(1,1,1),1,0.7)
local LLO=Instance.new("TextLabel",LLOGO)LLO.Size=UDim2.new(1,0,1,0)LLO.Text="⚡"LLO.TextColor3=BG LLO.Font=Enum.Font.GothamBold LLO.TextSize=11 LLO.BackgroundTransparency=1
local LT=Instance.new("TextLabel",LH)LT.Size=UDim2.new(0,110,1,0)LT.Position=UDim2.new(0,34,0,0)LT.Text="FAST HUB"LT.TextColor3=TX LT.BackgroundTransparency=1 LT.Font=Enum.Font.GothamBlack LT.TextSize=14 LT.TextXAlignment=Enum.TextXAlignment.Left
GRAD(LT,Color3.fromRGB(255,255,255),Color3.fromRGB(120,255,200),0)
local VP=Instance.new("Frame",LH)VP.Size=UDim2.new(0,40,0,18)VP.Position=UDim2.new(1,-48,0,11)VP.BackgroundColor3=AC COR(VP,9)
local VPT=Instance.new("TextLabel",VP)VPT.Size=UDim2.new(1,0,1,0)VPT.Text="V1.0"VPT.TextColor3=BG VPT.Font=Enum.Font.GothamBold VPT.TextSize=10 VPT.BackgroundTransparency=1
local LC=Instance.new("Frame",LF)LC.Size=UDim2.new(1,-16,1,-92)LC.Position=UDim2.new(0,8,0,48)LC.BackgroundTransparency=1
local GP=Instance.new("Frame",LC)GP.Size=UDim2.new(1,0,1,0)GP.BackgroundTransparency=1 Instance.new("UIListLayout",GP).Padding=UDim.new(0,10)
local SF=Instance.new("Frame",GP)SF.Size=UDim2.new(1,0,0,36)SF.BackgroundColor3=OFF SF.BackgroundTransparency=0.35 SF.BorderSizePixel=0 COR(SF,10)STK(SF,Color3.new(1,1,1),1,0.85)
local SI=Instance.new("TextLabel",SF)SI.Size=UDim2.new(0,24,0,24)SI.Position=UDim2.new(0,6,0,6)SI.Text="🔍"SI.BackgroundTransparency=1 SI.TextSize=12
local SB=Instance.new("TextBox",SF)SB.Size=UDim2.new(1,-40,1,0)SB.Position=UDim2.new(0,32,0,0)SB.BackgroundTransparency=1 SB.PlaceholderText="Search games..."SB.PlaceholderColor3=DK SB.Text=""SB.TextColor3=TX SB.Font=Enum.Font.Gotham SB.TextSize=13 SB.TextXAlignment=Enum.TextXAlignment.Left
local GB=Instance.new("TextButton",GP)GB.Size=UDim2.new(1,0,0,44)GB.BackgroundColor3=FR GB.BackgroundTransparency=0.4 GB.BorderSizePixel=0 GB.Text=""COR(GB,10)GRAD(GB,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)STK(GB,Color3.new(1,1,1),1,0.85)
local GBH=Instance.new("Frame",GB)GBH.Size=UDim2.new(0,20,0,20)GBH.Position=UDim2.new(0,10,0,12)GBH.BackgroundColor3=AC GBH.BackgroundTransparency=0.75 GBH.BorderSizePixel=0 COR(GBH,10)
local GD=Instance.new("Frame",GB)GD.Size=UDim2.new(0,12,0,12)GD.Position=UDim2.new(0,14,0,16)GD.BackgroundColor3=AC COR(GD,6)STK(GD,Color3.new(1,1,1),1,0.5)
local GBT=Instance.new("TextLabel",GB)GBT.Size=UDim2.new(1,-40,1,0)GBT.Position=UDim2.new(0,36,0,0)GBT.Text="+1 cut grass adventure"GBT.TextColor3=TX GBT.Font=Enum.Font.GothamBold GBT.TextSize=13 GBT.TextXAlignment=Enum.TextXAlignment.Left GBT.BackgroundTransparency=1
local IP=Instance.new("Frame",LC)IP.Size=UDim2.new(1,0,1,0)IP.BackgroundTransparency=1 IP.Visible=false Instance.new("UIListLayout",IP).Padding=UDim.new(0,6)
local function IROW(txt)local F=Instance.new("Frame",IP)F.Size=UDim2.new(1,0,0,26)F.BackgroundTransparency=1 local d=Instance.new("Frame",F)d.Size=UDim2.new(0,6,0,6)d.Position=UDim2.new(0,4,0,10)d.BackgroundColor3=AC COR(d,3)local l=Instance.new("TextLabel",F)l.Size=UDim2.new(1,-20,1,0)l.Position=UDim2.new(0,16,0,0)l.Text=txt l.TextColor3=TX l.Font=Enum.Font.Gotham l.TextSize=12 l.TextXAlignment=Enum.TextXAlignment.Left l.BackgroundTransparency=1 end
local IT1=Instance.new("TextLabel",IP)IT1.Size=UDim2.new(1,0,0,24)IT1.Text="FAST HUB V1.0"IT1.TextColor3=TX IT1.Font=Enum.Font.GothamBlack IT1.TextSize=16 IT1.TextXAlignment=Enum.TextXAlignment.Left IT1.BackgroundTransparency=1
local IT2=Instance.new("TextLabel",IP)IT2.Size=UDim2.new(1,0,0,16)IT2.Text="Auto-Farm & Utility Script"IT2.TextColor3=DK IT2.Font=Enum.Font.Gotham IT2.TextSize=11 IT2.TextXAlignment=Enum.TextXAlignment.Left IT2.BackgroundTransparency=1
local SEP=Instance.new("Frame",IP)SEP.Size=UDim2.new(1,0,0,1)SEP.BackgroundColor3=Color3.new(1,1,1)SEP.BackgroundTransparency=0.85 SEP.BorderSizePixel=0
IROW("Auto Strength")IROW("Auto Rebirth")IROW("Auto Loot")IROW("World Teleports")IROW("Anti-AFK")
local IT3=Instance.new("TextLabel",IP)IT3.Size=UDim2.new(1,0,0,20)IT3.Text="Made for Cut Grass Adventure"IT3.TextColor3=DK IT3.Font=Enum.Font.Gotham IT3.TextSize=11 IT3.TextXAlignment=Enum.TextXAlignment.Left IT3.BackgroundTransparency=1
local LTABS=Instance.new("Frame",LF)LTABS.Size=UDim2.new(1,-16,0,36)LTABS.Position=UDim2.new(0,8,1,-44)LTABS.BackgroundTransparency=1
local BTL=Instance.new("TextButton",LTABS)BTL.Size=UDim2.new(0.5,-3,1,0)BTL.BackgroundColor3=AC BTL.Text="Games"BTL.TextColor3=BG BTL.Font=Enum.Font.GothamBold BTL.TextSize=12 COR(BTL,10)STK(BTL,Color3.new(1,1,1),1,0.6)
local BTI=Instance.new("TextButton",LTABS)BTI.Size=UDim2.new(0.5,-3,1,0)BTI.Position=UDim2.new(0.5,3,0,0)BTI.BackgroundColor3=OFF BTI.BackgroundTransparency=0.3 BTI.Text="Info"BTI.TextColor3=DK BTI.Font=Enum.Font.GothamBold BTI.TextSize=12 COR(BTI,10)
local function setL(g)if g then GP.Visible=true IP.Visible=false TS:Create(BTL,TweenInfo.new(0.15),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()BTL.TextColor3=BG TS:Create(BTI,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()BTI.TextColor3=DK else GP.Visible=false IP.Visible=true TS:Create(BTI,TweenInfo.new(0.15),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()BTI.TextColor3=BG TS:Create(BTL,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()BTL.TextColor3=DK end end
BTL.MouseButton1Click:Connect(function()setL(true)end)
BTI.MouseButton1Click:Connect(function()setL(false)end)
local function showLauncher()LOPEN=true LF.Visible=true LFH.Visible=true end
local function hideLauncher()LOPEN=false LF.Visible=false LFH.Visible=false end
SB.TextChanged:Connect(function()local q=string.lower(SB.Text)GB.Visible=q==""or string.find("+1 cut grass adventure",q,1,true)~=nil end)
-- ==== HUB ====
local HUBOPEN=false
local MF=Instance.new("Frame",SG)MF.Size=UDim2.new(0,380,0,220)MF.Position=UDim2.new(0.5,-190,0.4,-110)MF.BackgroundColor3=BG MF.BackgroundTransparency=0.35 MF.BorderSizePixel=0 MF.Active=true MF.Draggable=true MF.ZIndex=1 MF.Visible=false
local HALO=Instance.new("Frame",SG)HALO.Size=UDim2.new(0,396,0,236)HALO.Position=UDim2.new(0.5,-198,0.4,-118)HALO.BackgroundColor3=AC HALO.BackgroundTransparency=0.85 HALO.BorderSizePixel=0 HALO.ZIndex=0 HALO.Visible=false
COR(HALO,14)STK(HALO,AC,1,0.75)COR(MF,12)STK(MF,AC,1.5,0.4)GRAD(MF,BG,Color3.fromRGB(16,20,28),90)
local function BRK(p)local b=Instance.new("Frame",MF)b.Size=UDim2.new(0,14,0,14)b.Position=p b.BackgroundTransparency=1 b.ZIndex=7 STK(b,AC,1.5,0.3)COR(b,4)end
BRK(UDim2.new(0,7,0,7))BRK(UDim2.new(1,-21,0,7))BRK(UDim2.new(0,7,1,-21))BRK(UDim2.new(1,-21,1,-21))
local TB=Instance.new("Frame",MF)TB.Size=UDim2.new(1,0,0,35)TB.BackgroundColor3=FR TB.BackgroundTransparency=0.35 TB.BorderSizePixel=0
COR(TB,12)GRAD(TB,Color3.fromRGB(22,26,34),Color3.fromRGB(13,16,22),90)
local LOGO=Instance.new("Frame",TB)LOGO.Size=UDim2.new(0,18,0,18)LOGO.Position=UDim2.new(0,10,0,8.5)LOGO.BackgroundColor3=AC COR(LOGO,9)GRAD(LOGO,AC,AC2,90)STK(LOGO,Color3.new(1,1,1),1,0.7)
local LO=Instance.new("TextLabel",LOGO)LO.Size=UDim2.new(1,0,1,0)LO.Text="⚡"LO.TextColor3=BG LO.Font=Enum.Font.GothamBold LO.TextSize=11 LO.BackgroundTransparency=1
local TBT=Instance.new("TextLabel",TB)TBT.Size=UDim2.new(0,180,1,0)TBT.Position=UDim2.new(0,34,0,0)TBT.Text="FAST HUB V1.0"TBT.TextColor3=TX TBT.BackgroundTransparency=1 TBT.Font=Enum.Font.GothamBlack TBT.TextSize=13 TBT.TextXAlignment=Enum.TextXAlignment.Left
GRAD(TBT,Color3.fromRGB(255,255,255),Color3.fromRGB(120,255,200),0)
local function createTopBtn(t,c,p,cb)local b=Instance.new("TextButton",TB)b.Size=UDim2.new(0,22,0,22)b.Position=p b.BackgroundColor3=OFF b.BackgroundTransparency=0.3 b.Text=t b.TextColor3=TX b.Font=Enum.Font.GothamBold b.TextSize=12 COR(b,7)STK(b,Color3.new(1,1,1),1,0.8)b.MouseButton1Click:Connect(cb)b.MouseEnter:Connect(function()TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=c,BackgroundTransparency=0}):Play()end)b.MouseLeave:Connect(function()TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()end)return b end
local OB=Instance.new("TextButton",SG)OB.Size=UDim2.new(0,60,0,60)OB.Position=UDim2.new(0,20,0.5,-30)OB.BackgroundColor3=AC OB.Text="" OB.Visible=false COR(OB,30)GRAD(OB,AC,AC2,90)STK(OB,Color3.new(1,1,1),1.5,0.6)
local OH=Instance.new("Frame",SG)OH.Size=UDim2.new(0,76,0,76)OH.Position=UDim2.new(0,12,0.5,-38)OH.BackgroundColor3=AC OH.BackgroundTransparency=0.8 OH.BorderSizePixel=0 OH.Visible=false COR(OH,38)
local ORR=Instance.new("Frame",SG)ORR.Size=UDim2.new(0,52,0,52)ORR.Position=UDim2.new(0,24,0.5,-26)ORR.BackgroundTransparency=1 ORR.Visible=false STK(ORR,AC,1,0.5)COR(ORR,26)
local OI=Instance.new("TextLabel",OB)OI.Size=UDim2.new(1,0,1,0)OI.Text="⚡"OI.TextColor3=Color3.new(1,1,1)OI.Font=Enum.Font.GothamBold OI.TextSize=24 OI.BackgroundTransparency=1
local function SPIN(f,t,g)task.spawn(function()while f.Parent do while not g() do task.wait(0.2) end TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Linear),{Rotation=f.Rotation+360}):Play()task.wait(t)end end)end
local function PULSE(f,a,b,t,g)task.spawn(function()while f.Parent do while not g() do task.wait(0.2) end TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=b}):Play()task.wait(t)TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=a}):Play()task.wait(t)end end)end
SPIN(ORR,10,function()return HUBOPEN end)PULSE(OH,0.75,0.55,1.2,function()return HUBOPEN end)PULSE(HALO,0.88,0.7,1.6,function()return HUBOPEN end)PULSE(LFH,0.9,0.75,1.4,function()return LOPEN end)
local function showHub()hideLauncher()HUBOPEN=true MF.Visible=true HALO.Visible=true MF.Size=UDim2.new(0,0,0,0)TS:Create(MF,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,380,0,220)}):Play()end
local OD,OG
OB.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then OD=i.Position OG=false end end)
OB.InputChanged:Connect(function(i)if OD and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.Mouse)then local p=i.Position if(p-OD).Magnitude>12 then OG=true end if OG then OB.Position=UDim2.fromOffset(p.X-30,p.Y-30)end end end)
OB.InputEnded:Connect(function(i)if OD and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1)then if not OG then OB.Visible=false OH.Visible=false ORR.Visible=false MF.Visible=true HALO.Visible=true MF.Size=UDim2.new(0,0,0,0)TS:Create(MF,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,380,0,220)}):Play()end OD=nil end end)
createTopBtn("–",Color3.fromRGB(90,220,160),UDim2.new(1,-56,0,6.5),function()MF.Visible=false HALO.Visible=false OB.Visible=true OH.Visible=true ORR.Visible=true OB.Size=UDim2.new(0,0,0,0)TS:Create(OB,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,60,0,60)}):Play()end)
createTopBtn("X",Color3.fromRGB(255,90,90),UDim2.new(1,-28,0,6.5),function()_G.FarmActive,_G.RebirthActive,_G.LootActive=false,false,false HUBOPEN=false MF.Visible=false HALO.Visible=false OB.Visible=false OH.Visible=false ORR.Visible=false showLauncher()end)
local TF=Instance.new("Frame",MF)TF.Size=UDim2.new(0,100,1,-35)TF.Position=UDim2.new(0,0,0,35)TF.BackgroundColor3=FR TF.BackgroundTransparency=0.35 TF.BorderSizePixel=0
local TFL=Instance.new("UIListLayout",TF)TFL.Padding=UDim.new(0,6)
local PC=Instance.new("Frame",MF)PC.Size=UDim2.new(1,-120,1,-45)PC.Position=UDim2.new(0,110,0,40)PC.BackgroundTransparency=1
local PKG=RS:WaitForChild("Packages")local IDX=PKG:WaitForChild("_Index")local SS=IDX["acecateer_knit@1.7.2"].knit.Services.StrengthService local CE=SS.RE.ClickRequested local R2=IDX["acecateer_knit@1.7.2"].knit.Services.RebirtService local RE=R2.RE.RebirthButtonClicked
local tabs={}local cur=nil
local function AddTab(n)local pg=Instance.new("Frame",PC)pg.Size=UDim2.new(1,0,1,0)pg.BackgroundTransparency=1 pg.Visible=false Instance.new("UIListLayout",pg).Padding=UDim.new(0,8)local b=Instance.new("TextButton",TF)b.Size=UDim2.new(1,-8,0,36)b.Position=UDim2.new(0,4,0,0)b.BackgroundColor3=OFF b.BackgroundTransparency=0.25 b.BorderSizePixel=0 b.Text=n b.TextColor3=DK b.Font=Enum.Font.GothamBold b.TextSize=12 COR(b,10)local bs=STK(b,AC,1,0.9)local ind=Instance.new("Frame",b)ind.Size=UDim2.new(0,3,0,18)ind.Position=UDim2.new(0,8,0.5,-9)ind.BackgroundColor3=AC ind.BackgroundTransparency=1 COR(ind,2)b.MouseButton1Click:Connect(function()for _,t in pairs(tabs)do t.pg.Visible=false t.b.TextColor3=DK TS:Create(t.bs,TweenInfo.new(0.15),{Transparency=0.9}):Play()TS:Create(t.ind,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play()end pg.Visible=true b.TextColor3=AC TS:Create(bs,TweenInfo.new(0.15),{Transparency=0.2}):Play()TS:Create(ind,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play()end)tabs[n]={pg=pg,b=b,bs=bs,ind=ind}if not cur then pg.Visible=true b.TextColor3=AC bs.Transparency=0.2 ind.BackgroundTransparency=0 cur=n end return pg end
local function CreateToggle(pp,txt,gv,cb)local F=Instance.new("Frame",pp)F.Size=UDim2.new(1,0,0,42)F.BackgroundColor3=FR F.BackgroundTransparency=0.4 F.BorderSizePixel=0 COR(F,10)GRAD(F,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)STK(F,Color3.new(1,1,1),1,0.9)local l=Instance.new("TextLabel",F)l.Size=UDim2.new(0.62,0,1,0)l.Position=UDim2.new(0,12,0,0)l.Text=txt l.TextColor3=TX l.Font=Enum.Font.Gotham l.TextSize=12 l.TextXAlignment=Enum.TextXAlignment.Left l.BackgroundTransparency=1 local sw=Instance.new("TextButton",F)sw.Size=UDim2.new(0,40,0,20)sw.Position=UDim2.new(1,-46,0.5,-10)sw.BackgroundColor3=OFF sw.BackgroundTransparency=0.4 sw.Text="" COR(sw,10)local sws=STK(sw,Color3.new(1,1,1),1,0.9)local ind=Instance.new("Frame",sw)ind.Size=UDim2.new(0,14,0,14)ind.Position=UDim2.new(0,3,0,3)ind.BackgroundColor3=TX COR(ind,7)STK(ind,BG,1,0)_G[gv]=false sw.MouseButton1Click:Connect(function()_G[gv]=not _G[gv]if _G[gv]then TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()TS:Create(sws,TweenInfo.new(0.2),{Color=AC,Transparency=0.2}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(1,-17,0,3),BackgroundColor3=BG}):Play()task.spawn(cb)else TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=OFF,BackgroundTransparency=0.4}):Play()TS:Create(sws,TweenInfo.new(0.2),{Color=Color3.new(1,1,1),Transparency=0.9}):Play()TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0,3),BackgroundColor3=TX}):Play()end end)end
local FP=AddTab("Farming")
CreateToggle(FP,"Auto Strength","FarmActive",function()while _G.FarmActive do CE:FireServer()task.wait(0.01)end end)
CreateToggle(FP,"Auto Rebirth","RebirthActive",function()while _G.RebirthActive do RE:FireServer()task.wait(1.2)end end)
local WC={[1]={s=Vector3.new(-933,38,-7),b=Vector3.new(688,37,6)},[2]={s=Vector3.new(-917,38,1705),b=Vector3.new(938,37,1702)}}
local NC=false
game:GetService("RunService").Stepped:Connect(function()if NC then local c=LP.Character if c then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end end end)
local function SN(on)NC=on local c=LP.Character if c then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=not on end end end end
local function GY(x,z)local r=workspace:Raycast(Vector3.new(x,1000,z),Vector3.new(0,-3000,0))return r and r.Position.Y or nil end
local function TP(p)local c=LP.Character if not c then return end local h=c:FindFirstChild("HumanoidRootPart")if h then _G.AntiGameplayPaused=true for _,g in ipairs({workspace:FindFirstChild("GameplayPaused"),RS:FindFirstChild("GameplayPaused"),LP:FindFirstChild("GameplayPaused")})do if g and g:IsA("ValueBase")then pcall(function()g.Value=false end)end end h.Velocity=Vector3.zero h.AssemblyLinearVelocity=Vector3.zero local _,ry=h.CFrame.Rotation:ToOrientation()local x,z=p.X,p.Z local py=p.Y if not NC then local gy=GY(x,z)if gy then py=gy+3 end end h.CFrame=CFrame.new(x,py,z)*CFrame.Angles(0,ry,0)end end
local WBS={}
local function RW()for _,s in ipairs(WBS)do local w1=_G.SelectedWorld==1 local w2=not w1 s[1].BackgroundColor3=w1 and AC or OFF s[1].TextColor3=w1 and BG or TX s[2].BackgroundColor3=w2 and AC or OFF s[2].TextColor3=w2 and BG or TX end end
local function CWS(pp)local F=Instance.new("Frame",pp)F.Size=UDim2.new(1,0,0,42)F.BackgroundColor3=FR F.BackgroundTransparency=0.4 F.BorderSizePixel=0 COR(F,10)GRAD(F,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)STK(F,Color3.new(1,1,1),1,0.9)local l=Instance.new("TextLabel",F)l.Size=UDim2.new(0.45,0,1,0)l.Position=UDim2.new(0,12,0,0)l.Text="Select World"l.TextColor3=TX l.Font=Enum.Font.Gotham l.TextSize=12 l.TextXAlignment=Enum.TextXAlignment.Left l.BackgroundTransparency=1 local b1=Instance.new("TextButton",F)b1.Size=UDim2.new(0,80,0,28)b1.Position=UDim2.new(1,-168,0.5,-14)b1.Text="World 1"b1.Font=Enum.Font.GothamBold b1.TextSize=12 COR(b1,8)STK(b1,Color3.new(1,1,1),1,0.9)local b2=Instance.new("TextButton",F)b2.Size=UDim2.new(0,80,0,28)b2.Position=UDim2.new(1,-84,0.5,-14)b2.Text="World 2"b2.Font=Enum.Font.GothamBold b2.TextSize=12 COR(b2,8)STK(b2,Color3.new(1,1,1),1,0.9)WBS[#WBS+1]={b1,b2}b1.MouseButton1Click:Connect(function()_G.SelectedWorld=1 RW()end)b2.MouseButton1Click:Connect(function()_G.SelectedWorld=2 RW()end)end
local TPg=AddTab("Teleport")
CWS(TPg)
local function CB(pp,txt,c1,c2,cb)local b=Instance.new("TextButton",pp)b.Size=UDim2.new(1,0,0,40)b.BackgroundColor3=c1 b.BackgroundTransparency=0.25 b.BorderSizePixel=0 b.Text=txt b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextSize=13 COR(b,10)GRAD(b,c1,c2,90)STK(b,Color3.new(1,1,1),1,0.85)b.MouseButton1Click:Connect(cb)b.MouseEnter:Connect(function()TS:Create(b,TweenInfo.new(0.12),{Size=UDim2.new(1,-8,0,40)}):Play()end)b.MouseLeave:Connect(function()TS:Create(b,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,40)}):Play()end)end
CB(TPg,"Teleport to Spawn",Color3.fromRGB(70,120,255),Color3.fromRGB(40,70,190),function()local w=WC[_G.SelectedWorld]if not w then return end TP(w.s)SN(false)end)
CB(TPg,"Teleport to Best Area",AC,AC2,function()local w=WC[_G.SelectedWorld]if not w then return end SN(true)TP(w.b)end)
local PPS=game:GetService("ProximityPromptService")local UIS=game:GetService("UserInputService")
local PM={}
local function SI(p)if p then if not PM[p]then PM[p]={p.MaxActivationDistance,p.RequiresLineOfSight}end p.MaxActivationDistance=10000 p.RequiresLineOfSight=false end end
local function RP()for p,o in pairs(PM)do if p and p.Parent then p.MaxActivationDistance=o[1]p.RequiresLineOfSight=o[2]end end PM={} end
local function CP(p)pcall(function()PPS:PromptButtonHoldBegan(p)end)task.wait(0.05)pcall(function()p:InputBegan(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)task.wait(0.05)pcall(function()p:InputEnded(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)task.wait(0.05)pcall(function()PPS:PromptButtonHoldEnded(p)end)end
local function BF()local c=LP.Character for _,n in ipairs{"BagFull","InventoryFull","BackpackFull"}do local a=LP:GetAttribute(n)if a~=nil then return a end if c then local a2=c:GetAttribute(n)if a2~=nil then return a2 end local v=c:FindFirstChild(n)if v and v:IsA("ValueBase")then return v.Value end end end local inv=c and(c:FindFirstChild("Inventory")or c:FindFirstChild("Bag"))or LP:FindFirstChild("Inventory")if inv then local cap=inv:GetAttribute("MaxSlots")or LP:GetAttribute("MaxSlots")or 40 local n=0 for _ in ipairs(inv:GetChildren())do n=n+1 end return n>=cap end return false end
local BZ={[1]="Zone_13"}
local function FZ(w)local zf=workspace:FindFirstChild("zones")if not zf then return nil,nil end local zn=BZ[w]local z=zn and zf:FindFirstChild(zn)or nil if z then return z,z:IsA("BasePart")and z.Position or(z:FindFirstChildWhichIsA("BasePart")and z:FindFirstChildWhichIsA("BasePart").Position)or nil end local bp=WC[w].b local bz,bd=nil,math.huge for _,z2 in ipairs(zf:GetChildren())do local cp=z2:IsA("BasePart")and z2.Position or(z2:FindFirstChildWhichIsA("BasePart")and z2:FindFirstChildWhichIsA("BasePart").Position)or nil if cp then local d=(cp-bp).Magnitude if d<bd then bd=d bz=z2 end end end return bz,bz and(bz:IsA("BasePart")and bz.Position or(bz:FindFirstChildWhichIsA("BasePart")and bz:FindFirstChildWhichIsA("BasePart").Position))or nil end
local function ZL(z)local out,seen={},{}for _,v in ipairs(z:GetDescendants())do if v:IsA("BasePart")then local pr=v:FindFirstChildOfClass("ProximityPrompt")or(v.Parent and v.Parent:FindFirstChildOfClass("ProximityPrompt"))if pr and not seen[pr]then seen[pr]=true out[#out+1]={p=v,pr=pr}end end end if #out==0 then for _,v in ipairs(z:GetDescendants())do if v:IsA("BasePart")and v~=z then out[#out+1]={p=v,pr=v:FindFirstChildOfClass("ProximityPrompt")}end end end return out end
local LT=AddTab("Loot")
CWS(LT)
_G.SelectedWorld=1
RW()
CreateToggle(LT,"Auto Collect Loot From Best Zone","LootActive",function()
while _G.LootActive do
if BF()then
local w=WC[_G.SelectedWorld]TP(w.s)SN(false)RP()
while _G.LootActive and BF()do task.wait(1)end
else
local w=_G.SelectedWorld
SN(true)
local z,zp=FZ(w)
if not z then TP(WC[w].b)task.wait(3)z,zp=FZ(w)end
TP(zp or WC[w].b)
task.wait(2.5)
local loot=z and ZL(z)or{}
if #loot==0 then task.wait(2)loot=z and ZL(z)or{} end
for _,it in ipairs(loot)do
if not _G.LootActive then break end
if BF()then break end
if it.pr then SI(it.pr)end
SN(true)
TP(it.p.Position)
task.wait(0.4)
if it.pr then CP(it.pr)end
task.wait(0.8)
end
end
end
SN(false)RP()_G.AntiGameplayPaused=false
end)
local MP=AddTab("Misc")
CreateToggle(MP,"Anti-AFK Avoidance","AntiAFK",function()local VU=game:GetService("VirtualUser")LP.Idled:Connect(function()if _G.AntiAFK then VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end end)end)
GB.MouseButton1Click:Connect(showHub)
GB.MouseEnter:Connect(function()TS:Create(GB,TweenInfo.new(0.12),{Size=UDim2.new(1,-6,0,44)}):Play()end)
GB.MouseLeave:Connect(function()TS:Create(GB,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,44)}):Play()end)
