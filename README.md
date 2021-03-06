# Convert code copied from PaintCode into Xojo GraphicsPath methods

PaintCode is great at authoring Bezier paths/shapes etc for use in code, but only outputs point/path info for Objective-C, Swift, and JavaScript. (And perhaps a few others, I forget.)

https://www.paintcodeapp.com

This Xojo IDE script takes a selection pasted from PaintCode (`Web ▸ JavaScript Canvas` only) ...

```
context.moveTo(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);
```

... and transforms it to:

```
context.MoveToPoint( 47.5, 0.25 )
context.AddCurveToPoint( 47.5, 26.35, 26.35, 47.5, 0.25, 47.5 )
context.AddCurveToPoint( -25.85, 47.5, -47, 26.35, -47, 0.25 )
context.AddCurveToPoint( -47, -25.85, -25.85, -47, 0.25, -47 )
context.AddCurveToPoint( 26.35, -47, 47.5, -25.85, 47.5, 0.25 )
```

If you rename the target object in the first line, then that rename is carried forward through all the subsequent lines.

In other words, if you are starting with something like this:

```
var path as GraphicsPath = new GraphicsPath()

// “context” in pasted code below is wrong, I want “path” to match declaration above

context.moveTo(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);

// back to Xojo code

g.FillPath( path, true )
```

... you rename the **first** `context` to `path` before running the script:

<pre><code>var path as GraphicsPath = new GraphicsPath()

<b style=“font-weight:900”>path</b>.moveTo(47.5, 0.25);
context.bezierCurveTo(47.5, 26.35, 26.35, 47.5, 0.25, 47.5);
context.bezierCurveTo(-25.85, 47.5, -47, 26.35, -47, 0.25);
context.bezierCurveTo(-47, -25.85, -25.85, -47, 0.25, -47);
context.bezierCurveTo(26.35, -47, 47.5, -25.85, 47.5, 0.25);

g.FillPath( path, true )
</code></pre>

Then, after running the script, the result is:

```
var path as GraphicsPath = new GraphicsPath()

path.MoveToPoint( 47.5, 0.25 )
path.AddCurveToPoint( 47.5, 26.35, 26.35, 47.5, 0.25, 47.5 )
path.AddCurveToPoint( -25.85, 47.5, -47, 26.35, -47, 0.25 )
path.AddCurveToPoint( -47, -25.85, -25.85, -47, 0.25, -47 )
path.AddCurveToPoint( 26.35, -47, 47.5, -25.85, 47.5, 0.25 )

g.FillPath( path, true )
```

**Note that the script only works when the exact lines you need transformed are selected.**

It’s also worth noting that all I was interested in was curves, so there’s no support for straight line segments or anything like that.

The only items that are handled are:

`moveTo` and `bezierCurveTo`

