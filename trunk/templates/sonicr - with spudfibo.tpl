<chart>
comment=Time for next bar: 0 min 2 sec
symbol=EURUSD
period=15
leftpos=3485
digits=4
scale=4
graph=1
fore=0
grid=0
volume=0
scroll=1
shift=1
ohlc=1
askline=0
days=0
descriptions=0
shift_size=15
fixed_pos=0
window_left=0
window_top=0
window_right=1264
window_bottom=497
window_type=3
background_color=0
foreground_color=16777215
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=65280
volumes_color=3329330
grid_color=10061943
askline_color=255
stops_color=255

<window>
height=217
<indicator>
name=main
<object>
type=10
object_name=FiboDn
period_flags=0
create_time=1246788565
color=255
style=2
weight=1
background=1
color2=6053069
style2=0
weight2=1
time_0=1246492800
value_0=1.370400
time_1=1246492800
value_1=1.387361
levels_ray=1
level_0=0.0000
description_0=(-23.6%) -  %$
level_1=0.1890
description_1=(-38.2%) -  %$
level_2=0.3460
description_2=(-50.0%) -  %$
level_3=0.5000
description_3=(-61.8%) -  %$
level_4=0.6910
description_4=(-76.4%) -  %$
level_5=1.0000
description_5=(-100.0%) -  %$
level_6=1.3110
description_6=(-123.6%) -  %$
level_7=1.5000
description_7=(-138.2%) -  %$
level_8=1.6540
description_8=(-150.0%) -  %$
level_9=1.8100
description_9=(-161.8%) -  %$
level_10=2.0000
description_10=(-176.4%) -  %$
level_11=2.3090
description_11=(-200.0%) -  %$
level_12=2.9600
description_12=(-250.0%) -  %$
level_13=3.6180
description_13=(-300.0%) -  %$
level_14=4.2720
description_14=(-350.0%) -  %$
level_15=4.9270
description_15=(-400.0%) -  %$
level_16=5.5780
description_16=(-450.0%) -  %$
level_17=6.2360
description_17=(-500.0%) -  %$
</object>
<object>
type=10
object_name=FiboIn
period_flags=0
create_time=1246788565
color=255
style=2
weight=1
background=1
color2=3107669
style2=0
weight2=1
time_0=1246492800
value_0=1.414800
time_1=1246492800
value_1=1.392600
levels_ray=1
level_0=0.0000
description_0=Daily LOW  (  0  ) -  %$
level_1=0.2360
description_1=(23.6) -  %$
level_2=0.3820
description_2=(38.2) -  %$
level_3=0.5000
description_3=(50.0) -  %$
level_4=0.6180
description_4=(61.8) -  %$
level_5=0.7640
description_5=(76.4) -  %$
level_6=1.0000
description_6=Daily HIGH  (100) -  %$
</object>
<object>
type=10
object_name=FiboUp
period_flags=0
create_time=1246788565
color=255
style=2
weight=1
background=1
color2=14772545
style2=0
weight2=1
time_0=1246492800
value_0=1.437000
time_1=1246492800
value_1=1.420039
levels_ray=1
level_0=0.0000
description_0=(123.6%) -  %$
level_1=0.1890
description_1=(138.2%) -  %$
level_2=0.3460
description_2=(150.0%) -  %$
level_3=0.5000
description_3=(161.8%) -  %$
level_4=0.6910
description_4=(176.4%) -  %$
level_5=1.0000
description_5=(200.0%) -  %$
level_6=1.3110
description_6=(223.6%) -  %$
level_7=1.5000
description_7=(238.2%) -  %$
level_8=1.6540
description_8=(250.0%) -  %$
level_9=1.8100
description_9=(261.8%) -  %$
level_10=2.0000
description_10=(276.4%) -  %$
level_11=2.3090
description_11=(300.0%) -  %$
level_12=2.9600
description_12=(350.0%) -  %$
level_13=3.6180
description_13=(400.0%) -  %$
level_14=4.2720
description_14=(450.0%) -  %$
level_15=4.9270
description_15=(500.0%) -  %$
level_16=5.5780
description_16=(550.0%) -  %$
level_17=6.2360
description_17=(600.0%) -  %$
</object>
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Moving Averages
flags=275
window_num=0
<inputs>
MA_Period=89
MA_Shift=0
MA_Method=1
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=16711935
style_0=0
weight_0=2
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=ZZ-Fractal A
flags=275
window_num=0
</expert>
shift_0=0
draw_0=1
color_0=55295
style_0=2
weight_0=0
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=34
shift=0
method=1
apply=0
color=16443110
style=2
weight=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=34
shift=0
method=1
apply=2
color=16443110
style=0
weight=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=34
shift=0
method=1
apply=3
color=16443110
style=0
weight=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=time to next bar
flags=275
window_num=0
<inputs>
numBars=630
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=255
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=16760576
style_1=0
weight_1=0
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=#SpudFibo_v2
flags=275
window_num=0
<inputs>
Indicator_On?=1
UpperFiboColor=14772545
UpperFiboOn=1
MainFiboColor=3107669
MainFiboOn=1
LowerFiboColor=6053069
LowerFiboOn=1
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=0
style_0=0
weight_0=0
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=18
<indicator>
name=Custom Indicator
<expert>
name=###QQE_Alert_MTF_v5###
flags=275
window_num=1
<inputs>
Smoothing=5
TimeFrame=0
ALERTS=------------------------------------------------------
CrossFiftyAlert=0
CrossFiftyEmail=0
CrossLineAlert=0
CrossLineEmail=0
BothAlert=0
BothEmail=0
MESSAGES=------------------------------------------------------
FiftyUpMessage=QQE Crossed 50 Line UP !!!
FiftyDownMessage=QQE Crossed 50 Line DOWN !!!
QQECrossUpMessage=QQE Lines Crossed UP !!!
QQECrossDownMessage=QQE Lines Crossed DOWN !!!
BothUpMessage=QQE Lines Are Crossed and 50 Line Broken UP !!!
BothDownMessage=QQE Lines Are Crossed and 50 Line Broken DOWN !!!
SOUNDS=------------------------------------------------------
FiftyUpSound=alert.wav
FiftyDownSound=alert.wav
QQECrossUpSound=alert.wav
QQECrossDownSound=alert.wav
BothUpSound=alert.wav
BothDownSound=alert.wav
DOT_VISIBILITY=------------------------------------------------------
FiftyUpDot=0
FiftyDownDot=0
QQECrossUpDot=0
QQECrossDownDot=0
BothUpDot=0
BothDownDot=0
DOT_COLORS=------------------------------------------------------
FiftyUpColor=16748574
FiftyDownColor=3937500
QQECrossUpColor=8421376
QQECrossDownColor=13353215
BothUpColor=16711680
BothDownColor=255
DOT_DISTANCE=------------------------------------------------------
Distance=30
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=16711680
style_0=0
weight_0=2
shift_1=0
draw_1=0
color_1=-1
style_1=2
weight_1=1
shift_2=0
draw_2=0
color_2=0
style_2=2
weight_2=1
levels_color=255
levels_style=0
levels_weight=1
level_0=50.0000
period_flags=0
show_data=1
<object>
type=23
object_name=Alarm_Crossing_Label1237248300
period_flags=0
create_time=1237248552
description=Analyze Exit
color=55295
font=Arial Black
fontsize=12
angle=0
background=0
corner=3
x_distance=1
y_distance=43
</object>
<object>
type=23
object_name=Alarm_Crossing_Label1238021100
period_flags=0
create_time=1238021120
description=Analyze Exit
color=55295
font=Arial Black
fontsize=12
angle=0
background=0
corner=3
x_distance=1
y_distance=43
</object>
<object>
type=23
object_name=Alarm_Crossing_Label1238169000
period_flags=0
create_time=1238365661
description=Analyze Exit
color=55295
font=Arial Black
fontsize=12
angle=0
background=0
corner=3
x_distance=1
y_distance=43
</object>
<object>
type=23
object_name=Alarm_Crossing_Label1239868800
period_flags=0
create_time=1239879796
description=Analyze Exit
color=55295
font=Arial Black
fontsize=12
angle=0
background=0
corner=3
x_distance=1
y_distance=43
</object>
<object>
type=23
object_name=MMLEVELS10
period_flags=0
create_time=1236671342
description=-218
color=17919
font=Arial Bold
fontsize=10
angle=0
background=0
corner=1
x_distance=30
y_distance=135
</object>
<object>
type=23
object_name=MMLEVELS11
period_flags=0
create_time=1236671342
description=Hi to Low
color=16777215
font=Arial
fontsize=10
angle=0
background=0
corner=1
x_distance=65
y_distance=150
</object>
<object>
type=23
object_name=MMLEVELS12
period_flags=0
create_time=1236671342
description=315
color=55295
font=Arial Bold
fontsize=10
angle=0
background=0
corner=1
x_distance=30
y_distance=150
</object>
<object>
type=23
object_name=MMLEVELS13
period_flags=0
create_time=1236671342
description=Daily Av
color=16777215
font=Arial
fontsize=10
angle=0
background=0
corner=1
x_distance=65
y_distance=165
</object>
<object>
type=23
object_name=MMLEVELS14
period_flags=0
create_time=1236671342
description=189
color=65280
font=Arial Bold
fontsize=10
angle=0
background=0
corner=1
x_distance=30
y_distance=165
</object>
<object>
type=23
object_name=MMLEVELS7
period_flags=0
create_time=1236671342
description=Spread
color=16777215
font=Arial
fontsize=10
angle=0
background=0
corner=1
x_distance=65
y_distance=120
</object>
<object>
type=23
object_name=MMLEVELS8
period_flags=0
create_time=1236671342
description=2
color=55295
font=Arial Bold
fontsize=10
angle=0
background=0
corner=1
x_distance=30
y_distance=120
</object>
<object>
type=23
object_name=MMLEVELS9
period_flags=0
create_time=1236671342
description=Pips to Open
color=16777215
font=Arial
fontsize=10
angle=0
background=0
corner=1
x_distance=65
y_distance=135
</object>
<object>
type=23
object_name=Order_Crossing_Label
period_flags=0
create_time=1239832811
description=Analyze Buy
color=65280
font=Arial Black
fontsize=12
angle=0
background=0
corner=3
x_distance=2
y_distance=25
</object>
<object>
type=23
object_name=text1
period_flags=0
create_time=1236670747
description=THV V 3
color=30583
font=Arial Black
fontsize=14
angle=0
background=0
corner=1
x_distance=13
y_distance=1
</object>
<object>
type=23
object_name=text2
period_flags=0
create_time=1236670747
description=System
color=30583
font=Batang
fontsize=9
angle=0
background=0
corner=1
x_distance=32
y_distance=26
</object>
<object>
type=23
object_name=text3
period_flags=0
create_time=1236670747
description=© By Cobraforex
color=32768
font=Arial
fontsize=8
angle=0
background=0
corner=1
x_distance=18
y_distance=41
</object>
</indicator>
</window>

<window>
height=28
<indicator>
name=Custom Indicator
<expert>
name=Sonic CCI
flags=275
window_num=3
<inputs>
CCI_Period=63
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=9109504
style_0=0
weight_0=2
shift_1=0
draw_1=2
color_1=1262987
style_1=0
weight_1=2
shift_2=0
draw_2=2
color_2=8421504
style_2=0
weight_2=2
shift_3=0
draw_3=2
color_3=65535
style_3=0
weight_3=2
shift_4=0
draw_4=0
color_4=12632256
style_4=0
weight_4=1
shift_5=0
draw_5=3
color_5=255
style_5=0
weight_5=1
arrow_5=167
shift_6=0
draw_6=3
color_6=3329330
style_6=0
weight_6=1
arrow_6=167
levels_color=6908265
levels_style=2
levels_weight=1
level_0=100.0000
level_1=200.0000
level_2=-100.0000
level_3=-200.0000
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=16
<indicator>
name=Custom Indicator
<expert>
name=Normalized_Volume_Oscillator
flags=275
window_num=4
<inputs>
VolumePeriod=10
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=16711680
style_0=0
weight_0=2
shift_1=0
draw_1=2
color_1=32768
style_1=0
weight_1=2
shift_2=0
draw_2=2
color_2=65280
style_2=0
weight_2=2
shift_3=0
draw_3=2
color_3=65535
style_3=0
weight_3=2
shift_4=0
draw_4=2
color_4=16777215
style_4=0
weight_4=2
period_flags=0
show_data=1
</indicator>
</window>
</chart>

