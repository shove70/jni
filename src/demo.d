import core.runtime;
import std.string;
import std.conv;

import jni;

extern (C):

jstring Java_com_xxxx_xxx_Class1_method1(JNIEnv* env, jclass clazz, jstring message)
{
	rt_init();

    const char* _message = env.GetStringUTFChars(message, null);

    const string result = _message.to!string ~ " return to Java function.";
    env.ReleaseStringUTFChars(message, _message);

    env.NewStringUTF(toStringz(result));
}
