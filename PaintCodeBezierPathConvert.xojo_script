if SelLength = 0 then

print( "This script only works when code is selected" )

return

end if

var lines() as String = SelText.Split( EndOfLine )

var indexOfFirstDot as Integer = lines( 0 ).IndexOf( "." )

var newName as String = lines( 0 ).Left( indexOfFirstDot )

var oldName as String = newName

if lines.Count > 1 then

indexOfFirstDot = lines( 1 ).IndexOf( "." )

oldName = lines( 1 ).Left( indexOfFirstDot )

end if

for i as Integer = 0 to lines.LastIndex

if newName <> oldName and i > 0 then

indexOfFirstDot = lines( i ).IndexOf( "." )

lines( i ) = newName + lines( i ).Middle( indexOfFirstDot )

end if

if lines( i ).IndexOf( ".moveTo" ) > -1 then

lines( i ) = lines( i ).Replace( ".moveTo", ".MoveToPoint" )

elseif lines( i ).IndexOf( ".bezierCurveTo" ) > -1 then

lines( i ) = lines( i ).Replace( ".bezierCurveTo", ".AddCurveToPoint" )

end if

lines( i ) = lines( i ).Replace( "(", "( " )

lines( i ) = lines( i ).Replace( ")", " )" )

lines( i ) = lines( i ).Replace( ";", "" )

next

SelText = ""

for i as Integer = 0 to lines.LastIndex

SelText = SelText + lines( i ) + EndOfLine

next

