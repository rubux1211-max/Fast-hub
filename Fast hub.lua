-- ============================================================
--  FAST HUB V1.0 — FINAL FIXES
--  Scrolling works, OH/ORR follows OB, drag works on touch,
--  notification shows, updated Discord link
-- ============================================================
local P=game:GetService("Players")
local TS=game:GetService("TweenService")
local RS=game:GetService("ReplicatedStorage")
local UIS=game:GetService("UserInputService")
local PPS=game:GetService("ProximityPromptService")
local LP=P.LocalPlayer
print("[FastHub] boot OK")

local function hook(obj,ev,fn)
	local ok,s=pcall(function()
		local sig=obj[ev]
		if typeof(sig)=="RBXScriptSignal" then sig:Connect(fn)
		else error("no signal: "..ev) end
	end)
	if not ok then print("[FastHub] ! hook failed: "..ev.." -> "..tostring(s)) end
	return ok
end

-- iOS-safe clipboard
local function copyText(txt)
	local ok
	ok=pcall(function() syn.writeclipboard(txt) end) if ok then return end
	ok=pcall(function() setclipboard(txt) end) if ok then return end
	ok=pcall(function() clipboard.set(txt) end) if ok then return end
	ok=pcall(function() toclipboard(txt) end) if ok then return end
	print("[FastHub] link: "..txt)
end

-- Notification (bigger frame, simpler, always visible)
local function notify(msg,sec)
	local nf=Instance.new("Frame",SG)
	nf.Size=UDim2.new(0,320,0,72)
	nf.Position=UDim2.new(0.5,-160,0.5,-36)
	nf.BackgroundColor3=Color3.fromRGB(10,12,17)
	nf.BackgroundTransparency=0.05
	nf.BorderSizePixel=0
	nf.ZIndex=100
	COR(nf,12)
	STK(nf,Color3.fromRGB(0,255,136),1.5,0.25)
	GRAD(nf,Color3.fromRGB(10,12,17),Color3.fromRGB(18,21,28),90)
	local nl=Instance.new("TextLabel",nf)
	nl.Size=UDim2.new(1,-12,1,0)
	nl.Position=UDim2.new(0,6,0,0)
	nl.Text=msg
	nl.TextColor3=Color3.fromRGB(240,244,250)
	nl.Font=Enum.Font.GothamBold
	nl.TextSize=11
	nl.BackgroundTransparency=1
	nl.ZIndex=101
	nl.TextWrapped=true
	task.delay(sec or 6,function()
		nf:Destroy()
	end)
end

-- GUI parent
local SG
local okCG=pcall(function()
	local cg=game:GetService("CoreGui")
	local old=cg:FindFirstChild("FastHub")
	if old then old:Destroy() end
	SG=Instance.new("ScreenGui",cg)
end)
if not okCG or not SG then
	local pg=LP:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
	local old=pg:FindFirstChild("FastHub")
	if old then old:Destroy() end
	SG=Instance.new("ScreenGui",pg)
end
SG.Name="FastHub"
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.DisplayOrder=999
print("[FastHub] GUI ready ("..SG.Parent.Name..")")

local BG=Color3.fromRGB(10,12,17)
local FR=Color3.fromRGB(18,21,28)
local AC=Color3.fromRGB(0,255,136)
local AC2=Color3.fromRGB(0,230,190)
local TX=Color3.fromRGB(240,244,250)
local DK=Color3.fromRGB(130,140,155)
local OFF=Color3.fromRGB(40,44,54)

local function GRAD(o,c1,c2,rot)
	local g=Instance.new("UIGradient",o)
	g.Color=ColorSequence.new(c1,c2)
	g.Rotation=rot or 90
	return g
end
local function STK(o,c,t,tr)
	local s=Instance.new("UIStroke",o)
	s.Color=c or Color3.new(1,1,1)
	s.Thickness=t or 1
	s.Transparency=tr or 0
	return s
end
local function COR(o,r)
	local c=Instance.new("UICorner",o)
	c.CornerRadius=UDim.new(0,r or 10)
	return c
end

local HUBOPEN=false
local LOPEN=true
local showHub,hideLauncher,showLauncher,closeAll

-- ==== HUB ====
local MF=Instance.new("Frame",SG)
MF.Size=UDim2.new(0,360,0,220)
MF.Position=UDim2.new(0.5,-180,0.4,-110)
MF.BackgroundColor3=BG
MF.BackgroundTransparency=0.35
MF.BorderSizePixel=0
MF.Active=true
MF.Draggable=true
MF.ZIndex=1
MF.Visible=false
COR(MF,12)
STK(MF,AC,1.5,0.4)
GRAD(MF,BG,Color3.fromRGB(16,20,28),90)

-- HALO is child of MF — moves automatically when MF is dragged
local HALO=Instance.new("Frame",MF)
HALO.Size=UDim2.new(1,16,1,16)
HALO.Position=UDim2.new(0,-8,0,-8)
HALO.BackgroundColor3=AC
HALO.BackgroundTransparency=0.85
HALO.BorderSizePixel=0
HALO.ZIndex=0
COR(HALO,14)
STK(HALO,AC,1,0.75)

local function BRK(p)
	local b=Instance.new("Frame",MF)
	b.Size=UDim2.new(0,14,0,14)
	b.Position=p
	b.BackgroundTransparency=1
	b.ZIndex=7
	STK(b,AC,1.5,0.3)
	COR(b,4)
end
BRK(UDim2.new(0,7,0,7))
BRK(UDim2.new(1,-21,0,7))
BRK(UDim2.new(0,7,1,-21))
BRK(UDim2.new(1,-21,1,-21))

local TB=Instance.new("Frame",MF)
TB.Size=UDim2.new(1,0,0,35)
TB.BackgroundColor3=FR
TB.BackgroundTransparency=0.35
TB.BorderSizePixel=0
COR(TB,12)
GRAD(TB,Color3.fromRGB(22,26,34),Color3.fromRGB(13,16,22),90)
local LOGO=Instance.new("Frame",TB)
LOGO.Size=UDim2.new(0,18,0,18)
LOGO.Position=UDim2.new(0,8,0,8.5)
LOGO.BackgroundColor3=AC
COR(LOGO,9)
GRAD(LOGO,AC,AC2,90)
STK(LOGO,Color3.new(1,1,1),1,0.7)
local LO=Instance.new("TextLabel",LOGO)
LO.Size=UDim2.new(1,0,1,0)
LO.Text="⚡"
LO.TextColor3=BG
LO.Font=Enum.Font.GothamBold
LO.TextSize=11
LO.BackgroundTransparency=1
local TBT=Instance.new("TextLabel",TB)
TBT.Size=UDim2.new(0,180,1,0)
TBT.Position=UDim2.new(0,32,0,0)
TBT.Text="FAST HUB V1.0"
TBT.TextColor3=TX
TBT.BackgroundTransparency=1
TBT.Font=Enum.Font.GothamBlack
TBT.TextSize=13
TBT.TextXAlignment=Enum.TextXAlignment.Left
GRAD(TBT,Color3.fromRGB(255,255,255),Color3.fromRGB(120,255,200),0)

local function createTopBtn(t,c,p,cb)
	local b=Instance.new("TextButton",TB)
	b.Size=UDim2.new(0,22,0,22)
	b.Position=p
	b.BackgroundColor3=OFF
	b.BackgroundTransparency=0.3
	b.Text=t
	b.TextColor3=TX
	b.Font=Enum.Font.GothamBold
	b.TextSize=12
	COR(b,7)
	STK(b,Color3.new(1,1,1),1,0.8)
	hook(b,"Activated",cb)
	pcall(function()
		b.MouseEnter:Connect(function()
			TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=c,BackgroundTransparency=0}):Play()
		end)
		b.MouseLeave:Connect(function()
			TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()
		end)
	end)
	return b
end

-- === MINIMIZED CIRCLE (OB with OH and ORR as children — they move together) ===
local OB=Instance.new("TextButton",SG)
OB.Size=UDim2.new(0,60,0,60)
OB.Position=UDim2.new(0,20,0.5,-30)
OB.BackgroundColor3=AC
OB.Text=""
OB.Visible=false
COR(OB,30)
GRAD(OB,AC,AC2,90)
STK(OB,Color3.new(1,1,1),1.5,0.6)
local OI=Instance.new("TextLabel",OB)
OI.Size=UDim2.new(1,0,1,0)
OI.Text="⚡"
OI.TextColor3=Color3.new(1,1,1)
OI.Font=Enum.Font.GothamBold
OI.TextSize=24
OI.BackgroundTransparency=1

-- OH and ORR parented to OB so they follow OB when dragged
local OH=Instance.new("Frame",OB)
OH.Size=UDim2.new(0,76,0,76)
OH.Position=UDim2.new(0,-8,0,-8)
OH.BackgroundColor3=AC
OH.BackgroundTransparency=0.8
OH.BorderSizePixel=0
OH.Visible=false
COR(OH,38)
local ORR=Instance.new("Frame",OB)
ORR.Size=UDim2.new(0,52,0,52)
ORR.Position=UDim2.new(0,4,0,4)
ORR.BackgroundTransparency=1
ORR.Visible=false
STK(ORR,AC,1,0.5)
COR(ORR,26)

local function SPIN(f,t,g)
	task.spawn(function()
		while f.Parent do
			while not g() do task.wait(0.2) end
			TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Linear),{Rotation=f.Rotation+360}):Play()
			task.wait(t)
		end
	end)
end
local function PULSE(f,a,b,t,g)
	task.spawn(function()
		while f.Parent do
			while not g() do task.wait(0.2) end
			TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=b}):Play()
			task.wait(t)
			TS:Create(f,TweenInfo.new(t,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=a}):Play()
			task.wait(t)
		end
	end)
end
SPIN(ORR,10,function()return HUBOPEN end)
PULSE(OH,0.75,0.55,1.2,function()return HUBOPEN end)
PULSE(HALO,0.88,0.7,1.6,function()return HUBOPEN end)

showHub=function()
	hideLauncher()
	HUBOPEN=true
	MF.Visible=true
	MF.Size=UDim2.new(0,0,0,0)
	TS:Create(MF,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,360,0,220)}):Play()
end

-- ==== LAUNCHER ====
local LF=Instance.new("Frame",SG)
LF.Size=UDim2.new(0,300,0,344)
LF.Position=UDim2.new(0.5,-150,0.4,-172)
LF.BackgroundColor3=BG
LF.BackgroundTransparency=0.35
LF.BorderSizePixel=0
LF.Active=true
LF.Draggable=true
LF.ZIndex=1
COR(LF,14)
STK(LF,AC,1,0.4)
GRAD(LF,BG,Color3.fromRGB(16,20,28),90)
local LFGLOW=Instance.new("Frame",LF)
LFGLOW.Size=UDim2.new(1,16,1,16)
LFGLOW.Position=UDim2.new(0,-8,0,-8)
LFGLOW.BackgroundColor3=AC
LFGLOW.BackgroundTransparency=0.88
LFGLOW.BorderSizePixel=0
LFGLOW.ZIndex=0
COR(LFGLOW,16)
STK(LFGLOW,AC,1,0.75)
PULSE(LFGLOW,0.9,0.75,1.4,function()return LOPEN end)

local LH=Instance.new("Frame",LF)
LH.Size=UDim2.new(1,0,0,40)
LH.BackgroundColor3=FR
LH.BackgroundTransparency=0.35
LH.BorderSizePixel=0
COR(LH,14)
GRAD(LH,Color3.fromRGB(22,26,34),Color3.fromRGB(13,16,22),90)
local LLOGO=Instance.new("Frame",LH)
LLOGO.Size=UDim2.new(0,18,0,18)
LLOGO.Position=UDim2.new(0,8,0,11)
LLOGO.BackgroundColor3=AC
COR(LLOGO,9)
GRAD(LLOGO,AC,AC2,90)
STK(LLOGO,Color3.new(1,1,1),1,0.7)
local LLO=Instance.new("TextLabel",LLOGO)
LLO.Size=UDim2.new(1,0,1,0)
LLO.Text="⚡"
LLO.TextColor3=BG
LLO.Font=Enum.Font.GothamBold
LLO.TextSize=11
LLO.BackgroundTransparency=1
local LTT=Instance.new("TextLabel",LH)
LTT.Size=UDim2.new(0,110,1,0)
LTT.Position=UDim2.new(0,32,0,0)
LTT.Text="FAST HUB"
LTT.TextColor3=TX
LTT.BackgroundTransparency=1
LTT.Font=Enum.Font.GothamBlack
LTT.TextSize=14
LTT.TextXAlignment=Enum.TextXAlignment.Left
GRAD(LTT,Color3.fromRGB(255,255,255),Color3.fromRGB(120,255,200),0)
local VP=Instance.new("Frame",LH)
VP.Size=UDim2.new(0,36,0,18)
VP.Position=UDim2.new(1,-72,0,11)
VP.BackgroundColor3=AC
COR(VP,9)
local VPT=Instance.new("TextLabel",VP)
VPT.Size=UDim2.new(1,0,1,0)
VPT.Text="V1.0"
VPT.TextColor3=BG
VPT.Font=Enum.Font.GothamBold
VPT.TextSize=10
VPT.BackgroundTransparency=1
local LX=Instance.new("TextButton",LH)
LX.Size=UDim2.new(0,24,0,24)
LX.Position=UDim2.new(1,-30,0,8)
LX.BackgroundColor3=OFF
LX.BackgroundTransparency=0.3
LX.Text="X"
LX.TextColor3=TX
LX.Font=Enum.Font.GothamBold
LX.TextSize=12
COR(LX,7)
STK(LX,Color3.new(1,1,1),1,0.8)

local LC=Instance.new("Frame",LF)
LC.Size=UDim2.new(1,-16,1,-96)
LC.Position=UDim2.new(0,8,0,48)
LC.BackgroundTransparency=1
local GP=Instance.new("Frame",LC)
GP.Size=UDim2.new(1,0,1,0)
GP.BackgroundTransparency=1
Instance.new("UIListLayout",GP).Padding=UDim.new(0,10)
local SF=Instance.new("Frame",GP)
SF.Size=UDim2.new(1,0,0,40)
SF.BackgroundColor3=OFF
SF.BackgroundTransparency=0.35
SF.BorderSizePixel=0
COR(SF,10)
STK(SF,Color3.new(1,1,1),1,0.85)
local SIC=Instance.new("TextLabel",SF)
SIC.Size=UDim2.new(0,26,0,26)
SIC.Position=UDim2.new(0,7,0,7)
SIC.Text="🔍"
SIC.BackgroundTransparency=1
SIC.TextSize=13
local SB=Instance.new("TextBox",SF)
SB.Size=UDim2.new(1,-44,1,0)
SB.Position=UDim2.new(0,34,0,0)
SB.BackgroundTransparency=1
SB.PlaceholderText="Search games..."
SB.PlaceholderColor3=DK
SB.Text=""
SB.TextColor3=TX
SB.Font=Enum.Font.Gotham
SB.TextSize=14
SB.TextXAlignment=Enum.TextXAlignment.Left
SB.ClearTextOnFocus=false
local GBRow=Instance.new("Frame",GP)
GBRow.Size=UDim2.new(1,0,0,48)
GBRow.BackgroundColor3=FR
GBRow.BackgroundTransparency=0.4
GBRow.BorderSizePixel=0
COR(GBRow,10)
GRAD(GBRow,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)
STK(GBRow,Color3.new(1,1,1),1,0.85)
local GBH=Instance.new("Frame",GBRow)
GBH.Size=UDim2.new(0,22,0,22)
GBH.Position=UDim2.new(0,13,0,13)
GBH.BackgroundColor3=AC
GBH.BackgroundTransparency=0.75
GBH.BorderSizePixel=0
COR(GBH,11)
local GD=Instance.new("Frame",GBRow)
GD.Size=UDim2.new(0,12,0,12)
GD.Position=UDim2.new(0,18,0,18)
GD.BackgroundColor3=AC
COR(GD,6)
STK(GD,Color3.new(1,1,1),1,0.5)
local GBT=Instance.new("TextLabel",GBRow)
GBT.Size=UDim2.new(1,-46,1,0)
GBT.Position=UDim2.new(0,42,0,0)
GBT.Text="+1 cut grass adventure"
GBT.TextColor3=TX
GBT.Font=Enum.Font.GothamBold
GBT.TextSize=13
GBT.TextXAlignment=Enum.TextXAlignment.Left
GBT.BackgroundTransparency=1
local GBO=Instance.new("TextButton",GBRow)
GBO.Size=UDim2.new(1,0,1,0)
GBO.BackgroundTransparency=1
GBO.Text=""
GBO.BorderSizePixel=0
GBO.ZIndex=5

-- LAUNCHER INFO TAB
local IP=Instance.new("Frame",LC)
IP.Size=UDim2.new(1,0,1,0)
IP.BackgroundTransparency=1
IP.Visible=false
local IPL=Instance.new("UIListLayout",IP)
IPL.Padding=UDim.new(0,8)
local IT1=Instance.new("TextLabel",IP)
IT1.Size=UDim2.new(1,0,0,80)
IT1.Text="Fast Hub is still in active development and may encounter crashes, not working, or any bugs. Please tell us those bugs in our Discord server."
IT1.TextColor3=TX
IT1.Font=Enum.Font.Gotham
IT1.TextSize=13
IT1.BackgroundTransparency=1
IT1.TextWrapped=true
local DCB=Instance.new("TextButton",IP)
DCB.Size=UDim2.new(1,0,0,44)
DCB.BackgroundColor3=Color3.fromRGB(88,101,242)
DCB.BackgroundTransparency=0.15
DCB.BorderSizePixel=0
DCB.Text="JOIN DISCORD"
DCB.TextColor3=Color3.new(1,1,1)
DCB.Font=Enum.Font.GothamBlack
DCB.TextSize=14
COR(DCB,10)
GRAD(DCB,Color3.fromRGB(88,101,242),Color3.fromRGB(60,70,200),90)
STK(DCB,Color3.new(1,1,1),1.5,0.5)
local DCBL=Instance.new("TextLabel",IP)
DCBL.Size=UDim2.new(1,0,0,20)
DCBL.Text="https://discord.gg/JszAabwvS"
DCBL.TextColor3=DK
DCBL.Font=Enum.Font.Gotham
DCBL.TextSize=9
DCBL.BackgroundTransparency=1
local STL=Instance.new("TextLabel",IP)
STL.Size=UDim2.new(1,0,0,20)
STL.Text="Status: loading..."
STL.TextColor3=DK
STL.Font=Enum.Font.GothamBold
STL.TextSize=11
STL.BackgroundTransparency=1

local LTABS=Instance.new("Frame",LF)
LTABS.Size=UDim2.new(1,-16,0,38)
LTABS.Position=UDim2.new(0,8,1,-42)
LTABS.BackgroundTransparency=1
local BTL=Instance.new("TextButton",LTABS)
BTL.Size=UDim2.new(0.5,-3,1,0)
BTL.BackgroundColor3=AC
BTL.Text="Games"
BTL.TextColor3=BG
BTL.Font=Enum.Font.GothamBold
BTL.TextSize=13
COR(BTL,10)
STK(BTL,Color3.new(1,1,1),1,0.6)
local BTI=Instance.new("TextButton",LTABS)
BTI.Size=UDim2.new(0.5,-3,1,0)
BTI.Position=UDim2.new(0.5,3,0,0)
BTI.BackgroundColor3=OFF
BTI.BackgroundTransparency=0.3
BTI.Text="Info"
BTI.TextColor3=DK
BTI.Font=Enum.Font.GothamBold
BTI.TextSize=13
COR(BTI,10)

-- ==== LAUNCHER WIRING ====
local function setL(g)
	if g then
		GP.Visible=true
		IP.Visible=false
		pcall(function()
			TS:Create(BTL,TweenInfo.new(0.15),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()
			TS:Create(BTI,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()
		end)
		BTL.TextColor3=BG
		BTI.TextColor3=DK
	else
		GP.Visible=false
		IP.Visible=true
		pcall(function()
			TS:Create(BTI,TweenInfo.new(0.15),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()
			TS:Create(BTL,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()
		end)
		BTI.TextColor3=BG
		BTL.TextColor3=DK
	end
end
hook(BTL,"Activated",function()setL(true)end)
hook(BTI,"Activated",function()setL(false)end)

hideLauncher=function()
	LOPEN=false
	LF.Visible=false
end
showLauncher=function()
	LOPEN=true
	LF.Visible=true
end
closeAll=function()
	_G.FarmActive,_G.RebirthActive,_G.LootActive=false,false,false
	SG:Destroy()
end

-- Search polling
task.spawn(function()
	while SB and SB.Parent do
		task.wait(0.4)
		local q=string.lower(SB.Text or "")
		GBRow.Visible=(q=="")or string.find("+1 cut grass adventure",q,1,true)~=nil
	end
end)

-- Game card tap
hook(GBO,"Activated",function()
	pcall(function()
		if SB:IsFocused() then SB:ReleaseFocus() end
		TS:Create(GBRow,TweenInfo.new(0.1),{BackgroundColor3=AC,BackgroundTransparency=0.1}):Play()
		task.delay(0.15,function()
			TS:Create(GBRow,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(24,28,38),BackgroundTransparency=0.4}):Play()
		end)
	end)
	showHub()
end)

hook(LX,"Activated",closeAll)

-- Discord button (launcher) — NEW LINK
hook(DCB,"Activated",function()
	local link="https://discord.gg/JszAabwvS"
	copyText(link)
	notify("discord server invite link copied."..link.."                   Paste it into your browser<3.",6)
end)

-- Hover effects
pcall(function()
	LX.MouseEnter:Connect(function()
		TS:Create(LX,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(255,90,90),BackgroundTransparency=0}):Play()
	end)
	LX.MouseLeave:Connect(function()
		TS:Create(LX,TweenInfo.new(0.15),{BackgroundColor3=OFF,BackgroundTransparency=0.3}):Play()
	end)
	GBO.MouseEnter:Connect(function()
		TS:Create(GBRow,TweenInfo.new(0.12),{Size=UDim2.new(1,-4,0,48)}):Play()
	end)
	GBO.MouseLeave:Connect(function()
		TS:Create(GBRow,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,48)}):Play()
	end)
	DCB.MouseEnter:Connect(function()
		TS:Create(DCB,TweenInfo.new(0.12),{Size=UDim2.new(1,-6,0,44)}):Play()
	end)
	DCB.MouseLeave:Connect(function()
		TS:Create(DCB,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,44)}):Play()
	end)
end)

print("[FastHub] launcher done")

-- ==== HUB WIRING ====
-- FIXED: delta-based drag for the minimize circle (no more jumping)
local dragStartPos, dragStartTouch, isDraggingOB
hook(OB,"InputBegan",function(i)
	if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
		dragStartPos = OB.Position
		dragStartTouch = Vector2.new(i.Position.X, i.Position.Y)
		isDraggingOB = false
	end
end)
hook(OB,"InputChanged",function(i)
	if dragStartTouch and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.Mouse) then
		local current = Vector2.new(i.Position.X, i.Position.Y)
		if (current - dragStartTouch).Magnitude > 12 then
			isDraggingOB = true
			local dx = current.X - dragStartTouch.X
			local dy = current.Y - dragStartTouch.Y
			OB.Position = UDim2.fromOffset(dragStartPos.X.Offset + dx, dragStartPos.Y.Offset + dy)
		end
	end
end)
hook(OB,"InputEnded",function(i)
	if dragStartTouch and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then
		if not isDraggingOB then
			-- Tap — reopen hub
			OB.Visible=false
			OH.Visible=false
			ORR.Visible=false
			MF.Visible=true
			MF.Size=UDim2.new(0,0,0,0)
			TS:Create(MF,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,360,0,220)}):Play()
		end
		dragStartTouch = nil
	end
end)

createTopBtn("–",Color3.fromRGB(90,220,160),UDim2.new(1,-56,0,5),function()
	MF.Visible=false
	HALO.Visible=false
	OB.Visible=true
	OH.Visible=true
	ORR.Visible=true
	OB.Size=UDim2.new(0,0,0,0)
	TS:Create(OB,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,60,0,60)}):Play()
end)
createTopBtn("X",Color3.fromRGB(255,90,90),UDim2.new(1,-28,0,5),function()
	_G.FarmActive,_G.RebirthActive,_G.LootActive=false,false,false
	HUBOPEN=false
	MF.Visible=false
	OB.Visible=false
	OH.Visible=false
	ORR.Visible=false
	showLauncher()
end)
print("[FastHub] hub wiring done")

-- ==== GAME LOGIC (SCROLLABLE tabs) ====
xpcall(function()

local TF=Instance.new("Frame",MF)
TF.Size=UDim2.new(0,100,1,-35)
TF.Position=UDim2.new(0,0,0,35)
TF.BackgroundColor3=FR
TF.BackgroundTransparency=0.35
TF.BorderSizePixel=0
local TFL=Instance.new("UIListLayout",TF)
TFL.Padding=UDim.new(0,6)

-- ScrollingFrame with manual canvas size update (reliable)
local PC=Instance.new("ScrollingFrame",MF)
PC.Size=UDim2.new(1,-120,1,-45)
PC.Position=UDim2.new(0,110,0,40)
PC.BackgroundTransparency=1
PC.ScrollBarThickness=4
PC.ScrollBarImageColor3=AC
PC.BorderSizePixel=0
PC.CanvasSize=UDim2.new(0,0,0,0)

-- Non-blocking knit service lookup
local CE,RE
do
	local PKG=RS:FindFirstChild("Packages")
	if PKG then
		local IDX=PKG:FindFirstChild("_Index")
		if IDX then
			for _,mod in ipairs(IDX:GetChildren()) do
				if mod:FindFirstChild("knit") then
					local S=mod.knit:FindFirstChild("Services")
					if S then
						local SS=S:FindFirstChild("StrengthService")
						if SS and SS:FindFirstChild("RE") then CE=SS.RE:FindFirstChild("ClickRequested") end
						local R2=S:FindFirstChild("RebirtService")
						if R2 and R2:FindFirstChild("RE") then RE=R2.RE:FindFirstChild("RebirthButtonClicked") end
					end
					break
				end
			end
		end
	end
	if CE then print("[FastHub] Strength OK") else print("[FastHub] ! Strength not found") end
	if RE then print("[FastHub] Rebirth OK") else print("[FastHub] ! Rebirth not found") end
end

local tabs={}
local cur=nil
local function updateCanvas()
	-- Set canvas to the visible tab's absolute height + padding
	for _,t in pairs(tabs) do
		if t.pg.Visible then
			local h = t.pg.AbsoluteSize.Y + 10
			PC.CanvasSize = UDim2.new(0,0,0,math.max(h, PC.AbsoluteSize.Y + 1))
			-- ^ keep canvas at least as tall as the viewport so it never feels stuck
			return
		end
	end
	PC.CanvasSize = UDim2.new(0,0,0,PC.AbsoluteSize.Y + 1)
end

local function AddTab(n)
	local pg=Instance.new("Frame",PC)
	pg.Size=UDim2.new(1,0,0,0)
	pg.BackgroundTransparency=1
	pg.Visible=false
	pg.AutomaticSize=Enum.AutomaticSize.Y
	Instance.new("UIListLayout",pg).Padding=UDim.new(0,8)
	-- Update canvas whenever children change
	local ls=Instance.new("UISizeConstraint",pg) -- dummy to detect size changes
	pg.DescendantAdded:Connect(updateCanvas)
	pg.ChildAdded:Connect(updateCanvas)
	pg.ChildRemoved:Connect(updateCanvas)
	
	local b=Instance.new("TextButton",TF)
	b.Size=UDim2.new(1,-8,0,36)
	b.Position=UDim2.new(0,4,0,0)
	b.BackgroundColor3=OFF
	b.BackgroundTransparency=0.25
	b.BorderSizePixel=0
	b.Text=n
	b.TextColor3=DK
	b.Font=Enum.Font.GothamBold
	b.TextSize=12
	COR(b,10)
	local bs=STK(b,AC,1,0.9)
	local ind=Instance.new("Frame",b)
	ind.Size=UDim2.new(0,3,0,18)
	ind.Position=UDim2.new(0,8,0.5,-9)
	ind.BackgroundColor3=AC
	ind.BackgroundTransparency=1
	COR(ind,2)
	hook(b,"Activated",function()
		for _,t in pairs(tabs) do
			t.pg.Visible=false
			t.b.TextColor3=DK
			TS:Create(t.bs,TweenInfo.new(0.15),{Transparency=0.9}):Play()
			TS:Create(t.ind,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play()
		end
		pg.Visible=true
		b.TextColor3=AC
		TS:Create(bs,TweenInfo.new(0.15),{Transparency=0.2}):Play()
		TS:Create(ind,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play()
		-- update canvas immediately
		task.wait(0.05)
		updateCanvas()
	end)
	tabs[n]={pg=pg,b=b,bs=bs,ind=ind}
	if not cur then
		pg.Visible=true
		b.TextColor3=AC
		bs.Transparency=0.2
		ind.BackgroundTransparency=0
		cur=n
		task.wait(0.05)
		updateCanvas()
	end
	return pg
end

local function CreateToggle(pp,txt,gv,cb)
	local F=Instance.new("Frame",pp)
	F.Size=UDim2.new(1,0,0,42)
	F.BackgroundColor3=FR
	F.BackgroundTransparency=0.4
	F.BorderSizePixel=0
	COR(F,10)
	GRAD(F,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)
	STK(F,Color3.new(1,1,1),1,0.9)
	local l=Instance.new("TextLabel",F)
	l.Size=UDim2.new(0.62,0,1,0)
	l.Position=UDim2.new(0,12,0,0)
	l.Text=txt
	l.TextColor3=TX
	l.Font=Enum.Font.Gotham
	l.TextSize=12
	l.TextXAlignment=Enum.TextXAlignment.Left
	l.BackgroundTransparency=1
	local sw=Instance.new("TextButton",F)
	sw.Size=UDim2.new(0,40,0,20)
	sw.Position=UDim2.new(1,-46,0.5,-10)
	sw.BackgroundColor3=OFF
	sw.BackgroundTransparency=0.4
	sw.Text=""
	COR(sw,10)
	local sws=STK(sw,Color3.new(1,1,1),1,0.9)
	local ind=Instance.new("Frame",sw)
	ind.Size=UDim2.new(0,14,0,14)
	ind.Position=UDim2.new(0,3,0,3)
	ind.BackgroundColor3=TX
	COR(ind,7)
	STK(ind,BG,1,0)
	_G[gv]=false
	hook(sw,"Activated",function()
		_G[gv]=not _G[gv]
		if _G[gv] then
			TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=AC,BackgroundTransparency=0}):Play()
			TS:Create(sws,TweenInfo.new(0.2),{Color=AC,Transparency=0.2}):Play()
			TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(1,-17,0,3),BackgroundColor3=BG}):Play()
			task.spawn(cb)
		else
			TS:Create(sw,TweenInfo.new(0.2),{BackgroundColor3=OFF,BackgroundTransparency=0.4}):Play()
			TS:Create(sws,TweenInfo.new(0.2),{Color=Color3.new(1,1,1),Transparency=0.9}):Play()
			TS:Create(ind,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0,3),BackgroundColor3=TX}):Play()
		end
	end)
end

-- === FARMING ===
local FP=AddTab("Farming")
CreateToggle(FP,"Auto Strength","FarmActive",function()
	while _G.FarmActive do
		if CE then pcall(function()CE:FireServer()end) end
		task.wait(0.01)
	end
end)
CreateToggle(FP,"Auto Rebirth","RebirthActive",function()
	while _G.RebirthActive do
		if RE then pcall(function()RE:FireServer()end) end
		task.wait(1.2)
	end
end)

-- === WORLDS ===
local WC={
	[1]={s=Vector3.new(-933,38,-7),b=Vector3.new(688,37,6)},
	[2]={s=Vector3.new(-917,38,1705),b=Vector3.new(938,37,1702)}
}
local NC=false
game:GetService("RunService").Stepped:Connect(function()
	if NC then
		local c=LP.Character
		if c then
			for _,v in pairs(c:GetDescendants()) do
				if v:IsA("BasePart")then v.CanCollide=false end
			end
		end
	end
end)
local function SN(on)
	NC=on
	local c=LP.Character
	if c then
		for _,v in pairs(c:GetDescendants()) do
			if v:IsA("BasePart")then v.CanCollide=not on end
		end
	end
end
local function GY(x,z)
	local r=workspace:Raycast(Vector3.new(x,1000,z),Vector3.new(0,-3000,0))
	return r and r.Position.Y or nil
end
local function TP(p)
	local c=LP.Character
	if not c then return end
	local h=c:FindFirstChild("HumanoidRootPart")
	if h then
		_G.AntiGameplayPaused=true
		for _,g in ipairs({workspace:FindFirstChild("GameplayPaused"),RS:FindFirstChild("GameplayPaused"),LP:FindFirstChild("GameplayPaused")}) do
			if g and g:IsA("ValueBase")then pcall(function()g.Value=false end) end
		end
		h.Velocity=Vector3.zero
		h.AssemblyLinearVelocity=Vector3.zero
		local _,ry=h.CFrame.Rotation:ToOrientation()
		local x,z=p.X,p.Z
		local py=p.Y
		if not NC then
			local gy=GY(x,z)
			if gy then py=gy+3 end
		end
		h.CFrame=CFrame.new(x,py,z)*CFrame.Angles(0,ry,0)
	end
end

local WBS={}
local function RW()
	for _,s in ipairs(WBS) do
		local w1=_G.SelectedWorld==1
		local w2=not w1
		s[1].BackgroundColor3=w1 and AC or OFF
		s[1].TextColor3=w1 and BG or TX
		s[2].BackgroundColor3=w2 and AC or OFF
		s[2].TextColor3=w2 and BG or TX
	end
end
local function CWS(pp)
	local F=Instance.new("Frame",pp)
	F.Size=UDim2.new(1,0,0,42)
	F.BackgroundColor3=FR
	F.BackgroundTransparency=0.4
	F.BorderSizePixel=0
	COR(F,10)
	GRAD(F,Color3.fromRGB(24,28,38),Color3.fromRGB(16,19,27),90)
	STK(F,Color3.new(1,1,1),1,0.9)
	local l=Instance.new("TextLabel",F)
	l.Size=UDim2.new(0.45,0,1,0)
	l.Position=UDim2.new(0,12,0,0)
	l.Text="Select World"
	l.TextColor3=TX
	l.Font=Enum.Font.Gotham
	l.TextSize=12
	l.TextXAlignment=Enum.TextXAlignment.Left
	l.BackgroundTransparency=1
	local b1=Instance.new("TextButton",F)
	b1.Size=UDim2.new(0,80,0,28)
	b1.Position=UDim2.new(1,-168,0.5,-14)
	b1.Text="World 1"
	b1.Font=Enum.Font.GothamBold
	b1.TextSize=12
	COR(b1,8)
	STK(b1,Color3.new(1,1,1),1,0.9)
	local b2=Instance.new("TextButton",F)
	b2.Size=UDim2.new(0,80,0,28)
	b2.Position=UDim2.new(1,-84,0.5,-14)
	b2.Text="World 2"
	b2.Font=Enum.Font.GothamBold
	b2.TextSize=12
	COR(b2,8)
	STK(b2,Color3.new(1,1,1),1,0.9)
	WBS[#WBS+1]={b1,b2}
	hook(b1,"Activated",function()_G.SelectedWorld=1 RW()end)
	hook(b2,"Activated",function()_G.SelectedWorld=2 RW()end)
end

-- === TELEPORT ===
local TPg=AddTab("Teleport")
CWS(TPg)
local function CB(pp,txt,c1,c2,cb)
	local b=Instance.new("TextButton",pp)
	b.Size=UDim2.new(1,0,0,40)
	b.BackgroundColor3=c1
	b.BackgroundTransparency=0.25
	b.BorderSizePixel=0
	b.Text=txt
	b.TextColor3=Color3.new(1,1,1)
	b.Font=Enum.Font.GothamBold
	b.TextSize=13
	COR(b,10)
	GRAD(b,c1,c2,90)
	STK(b,Color3.new(1,1,1),1,0.85)
	hook(b,"Activated",cb)
	pcall(function()
		b.MouseEnter:Connect(function()
			TS:Create(b,TweenInfo.new(0.12),{Size=UDim2.new(1,-8,0,40)}):Play()
		end)
		b.MouseLeave:Connect(function()
			TS:Create(b,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,40)}):Play()
		end)
	end)
end
CB(TPg,"Teleport to Spawn",Color3.fromRGB(70,120,255),Color3.fromRGB(40,70,190),function()
	local w=WC[_G.SelectedWorld]
	if not w then return end
	TP(w.s)
	SN(false)
end)
CB(TPg,"Teleport to Best Area",AC,AC2,function()
	local w=WC[_G.SelectedWorld]
	if not w then return end
	SN(true)
	TP(w.b)
end)

-- === LOOT ===
local PM={}
local function SI(p)
	if p then
		if not PM[p] then PM[p]={p.MaxActivationDistance,p.RequiresLineOfSight} end
		p.MaxActivationDistance=10000
		p.RequiresLineOfSight=false
	end
end
local function RP()
	for p,o in pairs(PM) do
		if p and p.Parent then
			p.MaxActivationDistance=o[1]
			p.RequiresLineOfSight=o[2]
		end
	end
	PM={}
end
local function CP(p)
	pcall(function()PPS:PromptButtonHoldBegan(p)end)
	task.wait(0.05)
	pcall(function()p:InputBegan(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)
	task.wait(0.05)
	pcall(function()p:InputEnded(UIS.TouchEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,game)end)
	task.wait(0.05)
	pcall(function()PPS:PromptButtonHoldEnded(p)end)
end
local function BF()
	local c=LP.Character
	for _,n in ipairs{"BagFull","InventoryFull","BackpackFull"} do
		local a=LP:GetAttribute(n)
		if a~=nil then return a end
		if c then
			local a2=c:GetAttribute(n)
			if a2~=nil then return a2 end
			local v=c:FindFirstChild(n)
			if v and v:IsA("ValueBase")then return v.Value end
		end
	end
	local inv=c and(c:FindFirstChild("Inventory")or c:FindFirstChild("Bag"))or LP:FindFirstChild("Inventory")
	if inv then
		local cap=inv:GetAttribute("MaxSlots")or LP:GetAttribute("MaxSlots")or 40
		local n=0
		for _ in ipairs(inv:GetChildren())do n=n+1 end
		return n>=cap
	end
	return false
end
local BZ={[1]="Zone_13"}
local function FZ(w)
	local zf=workspace:FindFirstChild("zones")
	if not zf then return nil,nil end
	local zn=BZ[w]
	local z=zn and zf:FindFirstChild(zn)or nil
	if z then
		return z,z:IsA("BasePart")and z.Position or(z:FindFirstChildWhichIsA("BasePart")and z:FindFirstChildWhichIsA("BasePart").Position)or nil
	end
	local bp=WC[w].b
	local bz,bd=nil,math.huge
	for _,z2 in ipairs(zf:GetChildren()) do
		local cp=z2:IsA("BasePart")and z2.Position or(z2:FindFirstChildWhichIsA("BasePart")and z2:FindFirstChildWhichIsA("BasePart").Position)or nil
		if cp then
			local d=(cp-bp).Magnitude
			if d<bd then bd=d bz=z2 end
		end
	end
	return bz,bz and(bz:IsA("BasePart")and bz.Position or(bz:FindFirstChildWhichIsA("BasePart")and bz:FindFirstChildWhichIsA("BasePart").Position))or nil
end
local function ZL(z)
	local out,seen={},{}
	for _,v in ipairs(z:GetDescendants()) do
		if v:IsA("BasePart")then
			local pr=v:FindFirstChildOfClass("ProximityPrompt")or(v.Parent and v.Parent:FindFirstChildOfClass("ProximityPrompt"))
			if pr and not seen[pr]then
				seen[pr]=true
				out[#out+1]={p=v,pr=pr}
			end
		end
	end
	if #out==0 then
		for _,v in ipairs(z:GetDescendants()) do
			if v:IsA("BasePart")and v~=z then
				out[#out+1]={p=v,pr=v:FindFirstChildOfClass("ProximityPrompt")}
			end
		end
	end
	return out
end

local LT=AddTab("Loot")
CWS(LT)
_G.SelectedWorld=1
RW()
CreateToggle(LT,"Auto Collect Loot From Best Zone","LootActive",function()
	while _G.LootActive do
		if BF()then
			local w=WC[_G.SelectedWorld]
			TP(w.s)
			SN(false)
			RP()
			while _G.LootActive and BF()do task.wait(1) end
		else
			local w=_G.SelectedWorld
			SN(true)
			local z,zp=FZ(w)
			if not z then
				TP(WC[w].b)
				task.wait(3)
				z,zp=FZ(w)
			end
			TP(zp or WC[w].b)
			task.wait(2.5)
			local loot=z and ZL(z)or{}
			if #loot==0 then
				task.wait(2)
				loot=z and ZL(z)or{}
			end
			for _,it in ipairs(loot) do
				if not _G.LootActive then break end
				if BF()then break end
				if it.pr then SI(it.pr) end
				SN(true)
				TP(it.p.Position)
				task.wait(0.4)
				if it.pr then CP(it.pr) end
				task.wait(0.8)
			end
		end
	end
	SN(false)
	RP()
	_G.AntiGameplayPaused=false
end)

-- === MISC ===
local MP=AddTab("Misc")
local afkHooked=false
CreateToggle(MP,"Anti-AFK","AntiAFK",function()
	if afkHooked then return end
	afkHooked=true
	local VU=game:GetService("VirtualUser")
	LP.Idled:Connect(function()
		if _G.AntiAFK then
			VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(1)
			VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end
	end)
end)

-- === INFO TAB (hub) ===
local HInfo=AddTab("Info")
local HInfoMsg=Instance.new("TextLabel",HInfo)
HInfoMsg.Size=UDim2.new(1,0,0,80)
HInfoMsg.Text="Fast Hub is still in active development and may encounter crashes, not working, or any bugs. Please tell us those bugs in our Discord server."
HInfoMsg.TextColor3=TX
HInfoMsg.Font=Enum.Font.Gotham
HInfoMsg.TextSize=13
HInfoMsg.BackgroundTransparency=1
HInfoMsg.TextWrapped=true
local HDCB=Instance.new("TextButton",HInfo)
HDCB.Size=UDim2.new(1,0,0,44)
HDCB.BackgroundColor3=Color3.fromRGB(88,101,242)
HDCB.BackgroundTransparency=0.15
HDCB.BorderSizePixel=0
HDCB.Text="JOIN DISCORD"
HDCB.TextColor3=Color3.new(1,1,1)
HDCB.Font=Enum.Font.GothamBlack
HDCB.TextSize=14
COR(HDCB,10)
GRAD(HDCB,Color3.fromRGB(88,101,242),Color3.fromRGB(60,70,200),90)
STK(HDCB,Color3.new(1,1,1),1.5,0.5)
local HLink=Instance.new("TextLabel",HInfo)
HLink.Size=UDim2.new(1,0,0,20)
HLink.Text="https://discord.gg/JszAabwvS"
HLink.TextColor3=DK
HLink.Font=Enum.Font.Gotham
HLink.TextSize=9
HLink.BackgroundTransparency=1
hook(HDCB,"Activated",function()
	local link="https://discord.gg/JszAabwvS"
	copyText(link)
	notify("discord server invite link copied."..link.."                   Paste it into your browser<3.",6)
end)
pcall(function()
	HDCB.MouseEnter:Connect(function()
		TS:Create(HDCB,TweenInfo.new(0.12),{Size=UDim2.new(1,-6,0,44)}):Play()
	end)
	HDCB.MouseLeave:Connect(function()
		TS:Create(HDCB,TweenInfo.new(0.12),{Size=UDim2.new(1,0,0,44)}):Play()
	end)
end)

STL.Text="Status: READY"
STL.TextColor3=AC
print("[FastHub] tabs ready: Farming / Teleport / Loot / Misc / Info")

end, function(err)
	pcall(function()
		STL.Text="Status: ERROR"
		STL.TextColor3=Color3.fromRGB(255,90,90)
	end)
	print("[FastHub] game-logic ERROR: "..tostring(err))
end)

_G.FastHubOpen=showHub
print("[FastHub] ALL DONE — tap the game card")
