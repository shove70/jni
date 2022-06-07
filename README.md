# Java Native Access (JNI) Dlang Bindings.

Compile:

```
dmd src/demo.d src/jni.d -fPIC -shared -of./libdemo.so -defaultlib=libphobos2.so
```

demo.d:

```d
import core.runtime;
import std.string;
import std.conv;

import jni;

extern (C):

jstring Java_com_xxxx_xxx_ClassA_method1(JNIEnv* env, jclass clazz, jstring message)
{
    rt_init();

    const char* _message = env.GetStringUTFChars(message, null);

    const string result = _message.to!string ~ " return to Java function.";
    env.ReleaseStringUTFChars(message, _message);

    return env.NewStringUTF(toStringz(result));
}
```

