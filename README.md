# Convert code copied from PaintCode into Xojo GraphicsPath methods

PaintCode is great, but only outputs point/path info for Objective-C, Swift, and JavaScript. (And perhaps a few others, I forget.)


This Xojo IDE script takes a selection pasted from PaintCode (Web - JavaScript Canvas) ...

```context.moveTo(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);```

... and transforms it to:

```context.MoveToPoint( 47.5, 0.25 )
context.AddCurveToPoint( 47.5, 26.35, 26.35, 47.5, 0.25, 47.5 )
context.AddCurveToPoint( -25.85, 47.5, -47, 26.35, -47, 0.25 )
context.AddCurveToPoint( -47, -25.85, -25.85, -47, 0.25, -47 )
context.AddCurveToPoint( 26.35, -47, 47.5, -25.85, 47.5, 0.25 )```

If you rename the target object in the first line, then that rename is carried forward through all the subsequent lines.

In other words, if you are starting with something like this:

```var path as GraphicsPath = new GraphicsPath()

// “context” below is wrong, I want “path” from declaration above

context.moveTo(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);

g.FillPath( path, true )```

... you rename the **first** `context` to `path` before running the script:

```var path as GraphicsPath = new GraphicsPath()

**path**(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);

g.FillPath( path, true )```

Then, after running the script, the result is:

```var path as GraphicsPath = new GraphicsPath()

path.MoveToPoint( 47.5, 0.25 )
path.AddCurveToPoint( 47.5, 26.35, 26.35, 47.5, 0.25, 47.5 )
path.AddCurveToPoint( -25.85, 47.5, -47, 26.35, -47, 0.25 )
path.AddCurveToPoint( -47, -25.85, -25.85, -47, 0.25, -47 )
path.AddCurveToPoint( 26.35, -47, 47.5, -25.85, 47.5, 0.25 )

return path```

**Note that the script only works when the exact lines you need transformed are selected.**


