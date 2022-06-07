module jni;

import core.stdc.stdarg;

extern (C):
@system:
nothrow:
@nogc:

alias ubyte jboolean;
alias byte jbyte;
alias ushort jchar;
alias short jshort;
alias int jint;
alias long jlong;
alias float jfloat;
alias double jdouble;

alias jint jsize;

class _jobject {};
class _jclass : _jobject {};
class _jthrowable : _jobject {};
class _jstring : _jobject {};
class _jarray : _jobject {};
class _jbooleanArray : _jarray {};
class _jbyteArray : _jarray {};
class _jcharArray : _jarray {};
class _jshortArray : _jarray {};
class _jintArray : _jarray {};
class _jlongArray : _jarray {};
class _jfloatArray : _jarray {};
class _jdoubleArray : _jarray {};
class _jobjectArray : _jarray {};

alias _jobject* jobject;
alias _jclass* jclass;
alias _jthrowable* jthrowable;
alias _jstring* jstring;
alias _jarray* jarray;
alias _jbooleanArray* jbooleanArray;
alias _jbyteArray* jbyteArray;
alias _jcharArray* jcharArray;
alias _jshortArray* jshortArray;
alias _jintArray* jintArray;
alias _jlongArray* jlongArray;
alias _jfloatArray* jfloatArray;
alias _jdoubleArray* jdoubleArray;
alias _jobjectArray* jobjectArray;

alias jobject jweak;

union jvalue
{
    jboolean z;
    jbyte b;
    jchar c;
    jshort s;
    jint i;
    jlong j;
    jfloat f;
    jdouble d;
    jobject l;
}

struct _jfieldID;
alias _jfieldID* jfieldID;

struct _jmethodID;
alias _jmethodID* jmethodID;

/* Return values from jobjectRefType */
enum jobjectRefType
{
    JNIInvalidRefType    = 0,
    JNILocalRefType      = 1,
    JNIGlobalRefType     = 2,
    JNIWeakGlobalRefType = 3
}

/*
 * jboolean constants
 */

enum JNI_FALSE = 0;
enum JNI_TRUE  = 1;

/*
 * possible return values for JNI functions.
 */

enum JNI_OK        =  0;    /* success */
enum JNI_ERR       = -1;    /* unknown error */
enum JNI_EDETACHED = -2;    /* thread detached from the VM */
enum JNI_EVERSION  = -3;    /* JNI version error */
enum JNI_ENOMEM    = -4;    /* not enough memory */
enum JNI_EEXIST    = -5;    /* VM already created */
enum JNI_EINVAL    = -6;    /* invalid arguments */

/*
 * used in ReleaseScalarArrayElements
 */

enum JNI_COMMIT = 1; 
enum JNI_ABORT  = 2; 

/*
 * used in RegisterNatives to describe native method name, signature,
 * and function pointer.
 */

struct JNINativeMethod
{
    const(char)* name;
    const(char)* signature;
    void* fnPtr;
}

/*
 * JNI Native Method Interface.
 */

alias JNIEnv_ JNIEnv;

/*
 * JNI Invocation Interface.
 */

alias JavaVM_ JavaVM;

struct JNINativeInterface_
{
    void* reserved0;
    void* reserved1;
    void* reserved2;
    void* reserved3;

    jint function(JNIEnv* env) GetVersion;

    jclass function(JNIEnv* env, const(char)* name, jobject loader, const(jbyte)* buf, jsize len) DefineClass;
    jclass function(JNIEnv* env, const(char)* name) FindClass;

    jmethodID function(JNIEnv* env, jobject method) FromReflectedMethod;
    jfieldID function(JNIEnv* env, jobject field) FromReflectedField;

    jobject function(JNIEnv* env, jclass cls, jmethodID methodID, jboolean isStatic) ToReflectedMethod;

    jclass function(JNIEnv* env, jclass sub) GetSuperclass;
    jboolean function(JNIEnv* env, jclass sub, jclass sup) IsAssignableFrom;

    jobject function(JNIEnv* env, jclass cls, jfieldID fieldID, jboolean isStatic) ToReflectedField;

    jint function(JNIEnv* env, jthrowable obj) Throw;
    jint function(JNIEnv* env, jclass clazz, const(char)* msg) ThrowNew;
    jthrowable function(JNIEnv* env) ExceptionOccurred;
    void function(JNIEnv* env) ExceptionDescribe;
    void function(JNIEnv* env) ExceptionClear;
    void function(JNIEnv* env, const(char)* msg) FatalError;

    jint function(JNIEnv* env, jint capacity) PushLocalFrame;
    jobject function(JNIEnv* env, jobject result) PopLocalFrame;

    jobject function(JNIEnv* env, jobject lobj) NewGlobalRef;
    void function(JNIEnv* env, jobject gref) DeleteGlobalRef;
    void function(JNIEnv* env, jobject obj) DeleteLocalRef;
    jboolean function(JNIEnv* env, jobject obj1, jobject obj2) IsSameObject;
    jobject function(JNIEnv* env, jobject ref_) NewLocalRef;
    jint function(JNIEnv* env, jint capacity) EnsureLocalCapacity;

    jobject function(JNIEnv* env, jclass clazz) AllocObject;
    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) NewObject;
    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) NewObjectV;
    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) NewObjectA;

    jclass function(JNIEnv* env, jobject obj) GetObjectClass;
    jboolean function(JNIEnv* env, jobject obj, jclass clazz) IsInstanceOf;

    jmethodID function(JNIEnv* env, jclass clazz, const(char)* name, const(char)* sig) GetMethodID;

    jobject function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallObjectMethod;
    jobject function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallObjectMethodV;
    jobject function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallObjectMethodA;

    jboolean function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallBooleanMethod;
    jboolean function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallBooleanMethodV;
    jboolean function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallBooleanMethodA;

    jbyte function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallByteMethod;
    jbyte function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallByteMethodV;
    jbyte function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallByteMethodA;

    jchar function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallCharMethod;
    jchar function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallCharMethodV;
    jchar function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallCharMethodA;

    jshort function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallShortMethod;
    jshort function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallShortMethodV;
    jshort function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallShortMethodA;

    jint function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallIntMethod;
    jint function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallIntMethodV;
    jint function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallIntMethodA;

    jlong function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallLongMethod;
    jlong function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallLongMethodV;
    jlong function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallLongMethodA;

    jfloat function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallFloatMethod;
    jfloat function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallFloatMethodV;
    jfloat function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallFloatMethodA;

    jdouble function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallDoubleMethod;
    jdouble function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallDoubleMethodV;
    jdouble function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallDoubleMethodA;

    void function(JNIEnv* env, jobject obj, jmethodID methodID, ...) CallVoidMethod;
    void function(JNIEnv* env, jobject obj, jmethodID methodID, va_list args) CallVoidMethodV;
    void function(JNIEnv* env, jobject obj, jmethodID methodID, jvalue* args) CallVoidMethodA;

    jobject function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualObjectMethod;
    jobject function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualObjectMethodV;
    jobject function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualObjectMethodA;

    jboolean function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualBooleanMethod;
    jboolean function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualBooleanMethodV;
    jboolean function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualBooleanMethodA;

    jbyte function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualByteMethod;
    jbyte function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualByteMethodV;
    jbyte function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualByteMethodA;

    jchar function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualCharMethod;
    jchar function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualCharMethodV;
    jchar function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualCharMethodA;

    jshort function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualShortMethod;
    jshort function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualShortMethodV;
    jshort function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualShortMethodA;

    jint function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualIntMethod;
    jint function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualIntMethodV;
    jint function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualIntMethodA;

    jlong function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualLongMethod;
    jlong function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualLongMethodV;
    jlong function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualLongMethodA;

    jfloat function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualFloatMethod;
    jfloat function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualFloatMethodV;
    jfloat function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualFloatMethodA;

    jdouble function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualDoubleMethod;
    jdouble function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualDoubleMethodV;
    jdouble function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualDoubleMethodA;

    void function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, ...) CallNonvirtualVoidMethod;
    void function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, va_list args) CallNonvirtualVoidMethodV;
    void function(JNIEnv* env, jobject obj, jclass clazz, jmethodID methodID, jvalue* args) CallNonvirtualVoidMethodA;

    jfieldID function(JNIEnv* env, jclass clazz, const(char)* name, const(char)* sig) GetFieldID;

    jobject function(JNIEnv* env, jobject obj, jfieldID fieldID) GetObjectField;
    jboolean function(JNIEnv* env, jobject obj, jfieldID fieldID) GetBooleanField;
    jbyte function(JNIEnv* env, jobject obj, jfieldID fieldID) GetByteField;
    jchar function(JNIEnv* env, jobject obj, jfieldID fieldID) GetCharField;
    jshort function(JNIEnv* env, jobject obj, jfieldID fieldID) GetShortField;
    jint function(JNIEnv* env, jobject obj, jfieldID fieldID) GetIntField;
    jlong function(JNIEnv* env, jobject obj, jfieldID fieldID) GetLongField;
    jfloat function(JNIEnv* env, jobject obj, jfieldID fieldID) GetFloatField;
    jdouble function(JNIEnv* env, jobject obj, jfieldID fieldID) GetDoubleField;

    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jobject val) SetObjectField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jboolean val) SetBooleanField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jbyte val) SetByteField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jchar val) SetCharField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jshort val) SetShortField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jint val) SetIntField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jlong val) SetLongField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jfloat val) SetFloatField;
    void function(JNIEnv* env, jobject obj, jfieldID fieldID, jdouble val) SetDoubleField;

    jmethodID function(JNIEnv* env, jclass clazz, const(char)* name, const(char)* sig) GetStaticMethodID;

    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticObjectMethod;
    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticObjectMethodV;
    jobject function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticObjectMethodA;

    jboolean function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticBooleanMethod;
    jboolean function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticBooleanMethodV;
    jboolean function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticBooleanMethodA;

    jbyte function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticByteMethod;
    jbyte function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticByteMethodV;
    jbyte function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticByteMethodA;

    jchar function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticCharMethod;
    jchar function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticCharMethodV;
    jchar function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticCharMethodA;

    jshort function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticShortMethod;
    jshort function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticShortMethodV;
    jshort function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticShortMethodA;

    jint function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticIntMethod;
    jint function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticIntMethodV;
    jint function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticIntMethodA;

    jlong function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticLongMethod;
    jlong function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticLongMethodV;
    jlong function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticLongMethodA;

    jfloat function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticFloatMethod;
    jfloat function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticFloatMethodV;
    jfloat function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticFloatMethodA;

    jdouble function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticDoubleMethod;
    jdouble function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticDoubleMethodV;
    jdouble function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticDoubleMethodA;

    void function(JNIEnv* env, jclass clazz, jmethodID methodID, ...) CallStaticVoidMethod;
    void function(JNIEnv* env, jclass clazz, jmethodID methodID, va_list args) CallStaticVoidMethodV;
    void function(JNIEnv* env, jclass clazz, jmethodID methodID, jvalue* args) CallStaticVoidMethodA;

    jfieldID function(JNIEnv* env, jclass clazz, const(char)* name, const(char)* sig) GetStaticFieldID;

    jobject function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticObjectField;
    jboolean function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticBooleanField;
    jbyte function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticByteField;
    jchar function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticCharField;
    jshort function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticShortField;
    jint function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticIntField;
    jlong function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticLongField;
    jfloat function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticFloatField;
    jdouble function(JNIEnv* env, jclass clazz, jfieldID fieldID) GetStaticDoubleField;

    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jobject value) SetStaticObjectField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jboolean value) SetStaticBooleanField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jbyte value) SetStaticByteField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jchar value) SetStaticCharField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jshort value) SetStaticShortField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jint value) SetStaticIntField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jlong value) SetStaticLongField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jfloat value) SetStaticFloatField;
    void function(JNIEnv* env, jclass clazz, jfieldID fieldID, jdouble value) SetStaticDoubleField;

    jstring function(JNIEnv* env, const(jchar)* unicode, jsize len) NewString;
    jsize function(JNIEnv* env, jstring str) GetStringLength;
    const(jchar)* function(JNIEnv* env, jstring str, jboolean* isCopy) GetStringChars;
    void function(JNIEnv* env, jstring str, const(jchar)* chars) ReleaseStringChars;

    jstring function(JNIEnv* env, const(char)* utf) NewStringUTF;
    jsize function(JNIEnv* env, jstring str) GetStringUTFLength;
    const(char)* function(JNIEnv* env, jstring str, jboolean* isCopy) GetStringUTFChars;
    void function(JNIEnv* env, jstring str, const(char)* chars) ReleaseStringUTFChars;

    jsize function(JNIEnv* env, jarray array) GetArrayLength;

    jobjectArray function(JNIEnv* env, jsize len, jclass clazz, jobject init) NewObjectArray;
    jobject function(JNIEnv* env, jobjectArray array, jsize index) GetObjectArrayElement;
    void function(JNIEnv* env, jobjectArray array, jsize index, jobject val) SetObjectArrayElement;

    jbooleanArray function(JNIEnv* env, jsize len) NewBooleanArray;
    jbyteArray function(JNIEnv* env, jsize len) NewByteArray;
    jcharArray function(JNIEnv* env, jsize len) NewCharArray;
    jshortArray function(JNIEnv* env, jsize len) NewShortArray;
    jintArray function(JNIEnv* env, jsize len) NewIntArray;
    jlongArray function(JNIEnv* env, jsize len) NewLongArray;
    jfloatArray function(JNIEnv* env, jsize len) NewFloatArray;
    jdoubleArray function(JNIEnv* env, jsize len) NewDoubleArray;

    jboolean* function(JNIEnv* env, jbooleanArray array, jboolean* isCopy) GetBooleanArrayElements;
    jbyte* function(JNIEnv* env, jbyteArray array, jboolean* isCopy) GetByteArrayElements;
    jchar* function(JNIEnv* env, jcharArray array, jboolean* isCopy) GetCharArrayElements;
    jshort* function(JNIEnv* env, jshortArray array, jboolean* isCopy) GetShortArrayElements;
    jint* function(JNIEnv* env, jintArray array, jboolean* isCopy) GetIntArrayElements;
    jlong* function(JNIEnv* env, jlongArray array, jboolean* isCopy) GetLongArrayElements;
    jfloat* function(JNIEnv* env, jfloatArray array, jboolean* isCopy) GetFloatArrayElements;
    jdouble* function(JNIEnv* env, jdoubleArray array, jboolean* isCopy) GetDoubleArrayElements;

    void function(JNIEnv* env, jbooleanArray array, jboolean* elems, jint mode) ReleaseBooleanArrayElements;
    void function(JNIEnv* env, jbyteArray array, jbyte* elems, jint mode) ReleaseByteArrayElements;
    void function(JNIEnv* env, jcharArray array, jchar* elems, jint mode) ReleaseCharArrayElements;
    void function(JNIEnv* env, jshortArray array, jshort* elems, jint mode) ReleaseShortArrayElements;
    void function(JNIEnv* env, jintArray array, jint* elems, jint mode) ReleaseIntArrayElements;
    void function(JNIEnv* env, jlongArray array, jlong* elems, jint mode) ReleaseLongArrayElements;
    void function(JNIEnv* env, jfloatArray array, jfloat* elems, jint mode) ReleaseFloatArrayElements;
    void function(JNIEnv* env, jdoubleArray array, jdouble* elems, jint mode) ReleaseDoubleArrayElements;

    void function(JNIEnv* env, jbooleanArray array, jsize start, jsize len, jboolean* buf) GetBooleanArrayRegion;
    void function(JNIEnv* env, jbyteArray array, jsize start, jsize len, jbyte* buf) GetByteArrayRegion;
    void function(JNIEnv* env, jcharArray array, jsize start, jsize len, jchar* buf) GetCharArrayRegion;
    void function(JNIEnv* env, jshortArray array, jsize start, jsize len, jshort* buf) GetShortArrayRegion;
    void function(JNIEnv* env, jintArray array, jsize start, jsize len, jint* buf) GetIntArrayRegion;
    void function(JNIEnv* env, jlongArray array, jsize start, jsize len, jlong* buf) GetLongArrayRegion;
    void function(JNIEnv* env, jfloatArray array, jsize start, jsize len, jfloat* buf) GetFloatArrayRegion;
    void function(JNIEnv* env, jdoubleArray array, jsize start, jsize len, jdouble* buf) GetDoubleArrayRegion;

    void function(JNIEnv* env, jbooleanArray array, jsize start, jsize len, const(jboolean)* buf) SetBooleanArrayRegion;
    void function(JNIEnv* env, jbyteArray array, jsize start, jsize len, const(jbyte)* buf) SetByteArrayRegion;
    void function(JNIEnv* env, jcharArray array, jsize start, jsize len, const(jchar)* buf) SetCharArrayRegion;
    void function(JNIEnv* env, jshortArray array, jsize start, jsize len, const(jshort)* buf) SetShortArrayRegion;
    void function(JNIEnv* env, jintArray array, jsize start, jsize len, const(jint)* buf) SetIntArrayRegion;
    void function(JNIEnv* env, jlongArray array, jsize start, jsize len, const(jlong)* buf) SetLongArrayRegion;
    void function(JNIEnv* env, jfloatArray array, jsize start, jsize len, const(jfloat)* buf) SetFloatArrayRegion;
    void function(JNIEnv* env, jdoubleArray array, jsize start, jsize len, const(jdouble)* buf) SetDoubleArrayRegion;

    jint function(JNIEnv* env, jclass clazz, const(JNINativeMethod)* methods, jint nMethods) RegisterNatives;
    jint function(JNIEnv* env, jclass clazz) UnregisterNatives;

    jint function(JNIEnv* env, jobject obj) MonitorEnter;
    jint function(JNIEnv* env, jobject obj) MonitorExit;

    jint function(JNIEnv* env, JavaVM** vm) GetJavaVM;

    void function(JNIEnv* env, jstring str, jsize start, jsize len, jchar* buf) GetStringRegion;
    void function(JNIEnv* env, jstring str, jsize start, jsize len, char* buf) GetStringUTFRegion;

    void* function(JNIEnv* env, jarray array, jboolean* isCopy) GetPrimitiveArrayCritical;
    void function(JNIEnv* env, jarray array, void*, jint mode) ReleasePrimitiveArrayCritical;

    const(jchar)* function(JNIEnv* env, jstring str, jboolean* isCopy) GetStringCritical;
    void function(JNIEnv* env, jstring str, const(jchar)* cstring) ReleaseStringCritical;

    jweak function(JNIEnv* env, jobject obj) NewWeakGlobalRef;
    void function(JNIEnv* env, jweak ref_) DeleteWeakGlobalRef;

    jboolean function(JNIEnv* env) ExceptionCheck;

    jobject function(JNIEnv* env, void* address, jlong capacity) NewDirectByteBuffer;
    void* function(JNIEnv* env, jobject buf) GetDirectBufferAddress;
    jlong function(JNIEnv* env, jobject buf) GetDirectBufferCapacity;

    jobjectRefType function(JNIEnv* env, jobject obj) GetObjectRefType;
}

/*
 * We use inlined functions for C++ so that programmers can write:
 *
 *    env->FindClass("java/lang/String")
 *
 * in C++ rather than:
 *
 *    (*env)->FindClass(env, "java/lang/String")
 *
 * in C.
 */

struct JNIEnv_
{
    const(JNINativeInterface_)* functions;

    jint GetVersion() {
        return functions.GetVersion(cast(JNIEnv_*) &this);
    }

    jclass DefineClass(const char* name, jobject loader, const jbyte* buf, jsize len) {
        return functions.DefineClass(cast(JNIEnv_*) &this, name, loader, buf, len);
    }
    jclass FindClass(const char* name) {
        return functions.FindClass(cast(JNIEnv_*) &this, name);
    }

    jmethodID FromReflectedMethod(jobject method) {
        return functions.FromReflectedMethod(cast(JNIEnv_*) &this, method);
    }
    jfieldID FromReflectedField(jobject field) {
        return functions.FromReflectedField(cast(JNIEnv_*) &this, field);
    }

    jobject ToReflectedMethod(jclass cls, jmethodID methodID, jboolean isStatic) {
        return functions.ToReflectedMethod(cast(JNIEnv_*) &this, cls, methodID, isStatic);
    }

    jclass GetSuperclass(jclass sub) {
        return functions.GetSuperclass(cast(JNIEnv_*) &this, sub);
    }
    jboolean IsAssignableFrom(jclass sub, jclass sup) {
        return functions.IsAssignableFrom(cast(JNIEnv_*) &this, sub, sup);
    }

    jobject ToReflectedField(jclass cls, jfieldID fieldID, jboolean isStatic) {
        return functions.ToReflectedField(cast(JNIEnv_*) &this, cls, fieldID, isStatic);
    }

    jint Throw(jthrowable obj) {
        return functions.Throw(cast(JNIEnv_*) &this, obj);
    }
    jint ThrowNew(jclass clazz, const char* msg) {
        return functions.ThrowNew(cast(JNIEnv_*) &this, clazz, msg);
    }
    jthrowable ExceptionOccurred() {
        return functions.ExceptionOccurred(cast(JNIEnv_*) &this);
    }
    void ExceptionDescribe() {
        functions.ExceptionDescribe(cast(JNIEnv_*) &this);
    }
    void ExceptionClear() {
        functions.ExceptionClear(cast(JNIEnv_*) &this);
    }
    void FatalError(const char* msg) {
        functions.FatalError(cast(JNIEnv_*) &this, msg);
    }

    jint PushLocalFrame(jint capacity) {
        return functions.PushLocalFrame(cast(JNIEnv_*) &this, capacity);
    }
    jobject PopLocalFrame(jobject result) {
        return functions.PopLocalFrame(cast(JNIEnv_*) &this, result);
    }

    jobject NewGlobalRef(jobject lobj) {
        return functions.NewGlobalRef(cast(JNIEnv_*) &this, lobj);
    }
    void DeleteGlobalRef(jobject gref) {
        functions.DeleteGlobalRef(cast(JNIEnv_*) &this, gref);
    }
    void DeleteLocalRef(jobject obj) {
        functions.DeleteLocalRef(cast(JNIEnv_*) &this, obj);
    }
    jboolean IsSameObject(jobject obj1, jobject obj2) {
        return functions.IsSameObject(cast(JNIEnv_*) &this, obj1, obj2);
    }
    jobject NewLocalRef(jobject ref_) {
        return functions.NewLocalRef(cast(JNIEnv_*) &this, ref_);
    }
    jint EnsureLocalCapacity(jint capacity) {
        return functions.EnsureLocalCapacity(cast(JNIEnv_*) &this, capacity);
    }

    jobject AllocObject(jclass clazz) {
        return functions.AllocObject(cast(JNIEnv_*) &this, clazz);
    }
    jobject NewObject(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jobject result;
        va_start(args, methodID);
        result = functions.NewObjectV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jobject NewObjectV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.NewObjectV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jobject NewObjectA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.NewObjectA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jclass GetObjectClass(jobject obj) {
        return functions.GetObjectClass(cast(JNIEnv_*) &this, obj);
    }
    jboolean IsInstanceOf(jobject obj, jclass clazz) {
        return functions.IsInstanceOf(cast(JNIEnv_*) &this, obj, clazz);
    }

    jmethodID GetMethodID(jclass clazz, const char* name, const char* sig) {
        return functions.GetMethodID(cast(JNIEnv_*) &this, clazz, name, sig);
    }

    jobject CallObjectMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jobject result;
        va_start(args,methodID);
        result = functions.CallObjectMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jobject CallObjectMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallObjectMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jobject CallObjectMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallObjectMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jboolean CallBooleanMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jboolean result;
        va_start(args,methodID);
        result = functions.CallBooleanMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jboolean CallBooleanMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallBooleanMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jboolean CallBooleanMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallBooleanMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jbyte CallByteMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jbyte result;
        va_start(args,methodID);
        result = functions.CallByteMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jbyte CallByteMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallByteMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jbyte CallByteMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallByteMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jchar CallCharMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jchar result;
        va_start(args,methodID);
        result = functions.CallCharMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jchar CallCharMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallCharMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jchar CallCharMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallCharMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jshort CallShortMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jshort result;
        va_start(args,methodID);
        result = functions.CallShortMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jshort CallShortMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallShortMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jshort CallShortMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallShortMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jint CallIntMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jint result;
        va_start(args,methodID);
        result = functions.CallIntMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jint CallIntMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallIntMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jint CallIntMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallIntMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jlong CallLongMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jlong result;
        va_start(args,methodID);
        result = functions.CallLongMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jlong CallLongMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallLongMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jlong CallLongMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallLongMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jfloat CallFloatMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jfloat result;
        va_start(args,methodID);
        result = functions.CallFloatMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jfloat CallFloatMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallFloatMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jfloat CallFloatMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallFloatMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jdouble CallDoubleMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        jdouble result;
        va_start(args,methodID);
        result = functions.CallDoubleMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
        return result;
    }
    jdouble CallDoubleMethodV(jobject obj, jmethodID methodID, va_list args) {
        return functions.CallDoubleMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    jdouble CallDoubleMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        return functions.CallDoubleMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    void CallVoidMethod(jobject obj, jmethodID methodID, ...) {
        va_list args;
        va_start(args,methodID);
        functions.CallVoidMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
        va_end(args);
    }
    void CallVoidMethodV(jobject obj, jmethodID methodID, va_list args) {
        functions.CallVoidMethodV(cast(JNIEnv_*) &this, obj, methodID, args);
    }
    void CallVoidMethodA(jobject obj, jmethodID methodID, jvalue* args) {
        functions.CallVoidMethodA(cast(JNIEnv_*) &this, obj, methodID, args);
    }

    jobject CallNonvirtualObjectMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jobject result;
        va_start(args,methodID);
        result = functions.CallNonvirtualObjectMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jobject CallNonvirtualObjectMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualObjectMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jobject CallNonvirtualObjectMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualObjectMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jboolean CallNonvirtualBooleanMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jboolean result;
        va_start(args,methodID);
        result = functions.CallNonvirtualBooleanMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jboolean CallNonvirtualBooleanMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualBooleanMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jboolean CallNonvirtualBooleanMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualBooleanMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jbyte CallNonvirtualByteMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jbyte result;
        va_start(args,methodID);
        result = functions.CallNonvirtualByteMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jbyte CallNonvirtualByteMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualByteMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jbyte CallNonvirtualByteMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualByteMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jchar CallNonvirtualCharMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jchar result;
        va_start(args,methodID);
        result = functions.CallNonvirtualCharMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jchar CallNonvirtualCharMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualCharMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jchar CallNonvirtualCharMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualCharMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jshort CallNonvirtualShortMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jshort result;
        va_start(args,methodID);
        result = functions.CallNonvirtualShortMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jshort CallNonvirtualShortMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualShortMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jshort CallNonvirtualShortMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualShortMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jint CallNonvirtualIntMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jint result;
        va_start(args,methodID);
        result = functions.CallNonvirtualIntMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jint CallNonvirtualIntMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualIntMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jint CallNonvirtualIntMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualIntMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jlong CallNonvirtualLongMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jlong result;
        va_start(args,methodID);
        result = functions.CallNonvirtualLongMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jlong CallNonvirtualLongMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualLongMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jlong CallNonvirtualLongMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualLongMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jfloat CallNonvirtualFloatMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jfloat result;
        va_start(args,methodID);
        result = functions.CallNonvirtualFloatMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jfloat CallNonvirtualFloatMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualFloatMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jfloat CallNonvirtualFloatMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualFloatMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jdouble CallNonvirtualDoubleMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jdouble result;
        va_start(args,methodID);
        result = functions.CallNonvirtualDoubleMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jdouble CallNonvirtualDoubleMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallNonvirtualDoubleMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    jdouble CallNonvirtualDoubleMethodA(jobject obj, jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallNonvirtualDoubleMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    void CallNonvirtualVoidMethod(jobject obj, jclass clazz, jmethodID methodID, ...) {
        va_list args;
        va_start(args,methodID);
        functions.CallNonvirtualVoidMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
        va_end(args);
    }
    void CallNonvirtualVoidMethodV(jobject obj, jclass clazz, jmethodID methodID, va_list args) {
        functions.CallNonvirtualVoidMethodV(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }
    void CallNonvirtualVoidMethodA(jobject obj, jclass clazz,  jmethodID methodID, jvalue* args) {
        functions.CallNonvirtualVoidMethodA(cast(JNIEnv_*) &this, obj, clazz, methodID, args);
    }

    jfieldID GetFieldID(jclass clazz, const char* name, const char* sig) {
        return functions.GetFieldID(cast(JNIEnv_*) &this, clazz, name, sig);
    }

    jobject GetObjectField(jobject obj, jfieldID fieldID) {
        return functions.GetObjectField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jboolean GetBooleanField(jobject obj, jfieldID fieldID) {
        return functions.GetBooleanField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jbyte GetByteField(jobject obj, jfieldID fieldID) {
        return functions.GetByteField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jchar GetCharField(jobject obj, jfieldID fieldID) {
        return functions.GetCharField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jshort GetShortField(jobject obj, jfieldID fieldID) {
        return functions.GetShortField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jint GetIntField(jobject obj, jfieldID fieldID) {
        return functions.GetIntField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jlong GetLongField(jobject obj, jfieldID fieldID) {
        return functions.GetLongField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jfloat GetFloatField(jobject obj, jfieldID fieldID) {
        return functions.GetFloatField(cast(JNIEnv_*) &this, obj, fieldID);
    }
    jdouble GetDoubleField(jobject obj, jfieldID fieldID) {
        return functions.GetDoubleField(cast(JNIEnv_*) &this, obj, fieldID);
    }

    void SetObjectField(jobject obj, jfieldID fieldID, jobject val) {
        functions.SetObjectField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetBooleanField(jobject obj, jfieldID fieldID, jboolean val) {
        functions.SetBooleanField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetByteField(jobject obj, jfieldID fieldID, jbyte val) {
        functions.SetByteField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetCharField(jobject obj, jfieldID fieldID, jchar val) {
        functions.SetCharField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetShortField(jobject obj, jfieldID fieldID, jshort val) {
        functions.SetShortField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetIntField(jobject obj, jfieldID fieldID, jint val) {
        functions.SetIntField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetLongField(jobject obj, jfieldID fieldID, jlong val) {
        functions.SetLongField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetFloatField(jobject obj, jfieldID fieldID, jfloat val) {
        functions.SetFloatField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }
    void SetDoubleField(jobject obj, jfieldID fieldID, jdouble val) {
        functions.SetDoubleField(cast(JNIEnv_*) &this, obj, fieldID, val);
    }

    jmethodID GetStaticMethodID(jclass clazz, const char* name, const char* sig) {
        return functions.GetStaticMethodID(cast(JNIEnv_*) &this, clazz, name, sig);
    }

    jobject CallStaticObjectMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jobject result;
        va_start(args,methodID);
        result = functions.CallStaticObjectMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jobject CallStaticObjectMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticObjectMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jobject CallStaticObjectMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticObjectMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jboolean CallStaticBooleanMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jboolean result;
        va_start(args,methodID);
        result = functions.CallStaticBooleanMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jboolean CallStaticBooleanMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticBooleanMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jboolean CallStaticBooleanMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticBooleanMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jbyte CallStaticByteMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jbyte result;
        va_start(args,methodID);
        result = functions.CallStaticByteMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jbyte CallStaticByteMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticByteMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jbyte CallStaticByteMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticByteMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jchar CallStaticCharMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jchar result;
        va_start(args,methodID);
        result = functions.CallStaticCharMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jchar CallStaticCharMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticCharMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jchar CallStaticCharMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticCharMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jshort CallStaticShortMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jshort result;
        va_start(args,methodID);
        result = functions.CallStaticShortMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jshort CallStaticShortMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticShortMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jshort CallStaticShortMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticShortMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jint CallStaticIntMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jint result;
        va_start(args,methodID);
        result = functions.CallStaticIntMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jint CallStaticIntMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticIntMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jint CallStaticIntMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticIntMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jlong CallStaticLongMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jlong result;
        va_start(args,methodID);
        result = functions.CallStaticLongMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jlong CallStaticLongMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticLongMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jlong CallStaticLongMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticLongMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jfloat CallStaticFloatMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jfloat result;
        va_start(args,methodID);
        result = functions.CallStaticFloatMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jfloat CallStaticFloatMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticFloatMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jfloat CallStaticFloatMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticFloatMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    jdouble CallStaticDoubleMethod(jclass clazz, jmethodID methodID, ...) {
        va_list args;
        jdouble result;
        va_start(args,methodID);
        result = functions.CallStaticDoubleMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
        va_end(args);
        return result;
    }
    jdouble CallStaticDoubleMethodV(jclass clazz, jmethodID methodID, va_list args) {
        return functions.CallStaticDoubleMethodV(cast(JNIEnv_*) &this, clazz, methodID, args);
    }
    jdouble CallStaticDoubleMethodA(jclass clazz, jmethodID methodID, jvalue* args) {
        return functions.CallStaticDoubleMethodA(cast(JNIEnv_*) &this, clazz, methodID, args);
    }

    void CallStaticVoidMethod(jclass cls, jmethodID methodID, ...) {
        va_list args;
        va_start(args,methodID);
        functions.CallStaticVoidMethodV(cast(JNIEnv_*) &this, cls, methodID, args);
        va_end(args);
    }
    void CallStaticVoidMethodV(jclass cls, jmethodID methodID, va_list args) {
        functions.CallStaticVoidMethodV(cast(JNIEnv_*) &this, cls, methodID, args);
    }
    void CallStaticVoidMethodA(jclass cls, jmethodID methodID, jvalue* args) {
        functions.CallStaticVoidMethodA(cast(JNIEnv_*) &this, cls, methodID, args);
    }

    jfieldID GetStaticFieldID(jclass clazz, const char* name, const char* sig) {
        return functions.GetStaticFieldID(cast(JNIEnv_*) &this, clazz, name, sig);
    }
    jobject GetStaticObjectField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticObjectField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jboolean GetStaticBooleanField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticBooleanField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jbyte GetStaticByteField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticByteField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jchar GetStaticCharField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticCharField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jshort GetStaticShortField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticShortField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jint GetStaticIntField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticIntField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jlong GetStaticLongField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticLongField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jfloat GetStaticFloatField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticFloatField(cast(JNIEnv_*) &this, clazz, fieldID);
    }
    jdouble GetStaticDoubleField(jclass clazz, jfieldID fieldID) {
        return functions.GetStaticDoubleField(cast(JNIEnv_*) &this, clazz, fieldID);
    }

    void SetStaticObjectField(jclass clazz, jfieldID fieldID, jobject value) {
      functions.SetStaticObjectField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticBooleanField(jclass clazz, jfieldID fieldID, jboolean value) {
      functions.SetStaticBooleanField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticByteField(jclass clazz, jfieldID fieldID, jbyte value) {
      functions.SetStaticByteField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticCharField(jclass clazz, jfieldID fieldID, jchar value) {
      functions.SetStaticCharField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticShortField(jclass clazz, jfieldID fieldID, jshort value) {
      functions.SetStaticShortField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticIntField(jclass clazz, jfieldID fieldID, jint value) {
      functions.SetStaticIntField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticLongField(jclass clazz, jfieldID fieldID, jlong value) {
      functions.SetStaticLongField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticFloatField(jclass clazz, jfieldID fieldID, jfloat value) {
      functions.SetStaticFloatField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }
    void SetStaticDoubleField(jclass clazz, jfieldID fieldID, jdouble value) {
      functions.SetStaticDoubleField(cast(JNIEnv_*) &this, clazz, fieldID, value);
    }

    jstring NewString(const jchar* unicode, jsize len) {
        return functions.NewString(cast(JNIEnv_*) &this, unicode, len);
    }
    jsize GetStringLength(jstring str) {
        return functions.GetStringLength(cast(JNIEnv_*) &this, str);
    }
    const jchar* GetStringChars(jstring str, jboolean* isCopy) {
        return cast(jchar*) functions.GetStringChars(cast(JNIEnv_*) &this, str, isCopy);
    }
    void ReleaseStringChars(jstring str, const jchar* chars) {
        functions.ReleaseStringChars(cast(JNIEnv_*) &this, str, chars);
    }

    jstring NewStringUTF(const char* utf) {
        return functions.NewStringUTF(cast(JNIEnv_*) &this, utf);
    }
    jsize GetStringUTFLength(jstring str) {
        return functions.GetStringUTFLength(cast(JNIEnv_*) &this, str);
    }
    const char* GetStringUTFChars(jstring str, jboolean* isCopy) {
        return cast(char*) functions.GetStringUTFChars(cast(JNIEnv_*) &this, str, isCopy);
    }
    void ReleaseStringUTFChars(jstring str, const char* chars) {
        functions.ReleaseStringUTFChars(cast(JNIEnv_*) &this, str, chars);
    }

    jsize GetArrayLength(jarray array) {
        return functions.GetArrayLength(cast(JNIEnv_*) &this, array);
    }

    jobjectArray NewObjectArray(jsize len, jclass clazz, jobject init) {
        return functions.NewObjectArray(cast(JNIEnv_*) &this, len, clazz, init);
    }
    jobject GetObjectArrayElement(jobjectArray array, jsize index) {
        return functions.GetObjectArrayElement(cast(JNIEnv_*) &this, array, index);
    }
    void SetObjectArrayElement(jobjectArray array, jsize index, jobject val) {
        functions.SetObjectArrayElement(cast(JNIEnv_*) &this, array, index, val);
    }

    jbooleanArray NewBooleanArray(jsize len) {
        return functions.NewBooleanArray(cast(JNIEnv_*) &this, len);
    }
    jbyteArray NewByteArray(jsize len) {
        return functions.NewByteArray(cast(JNIEnv_*) &this, len);
    }
    jcharArray NewCharArray(jsize len) {
        return functions.NewCharArray(cast(JNIEnv_*) &this, len);
    }
    jshortArray NewShortArray(jsize len) {
        return functions.NewShortArray(cast(JNIEnv_*) &this, len);
    }
    jintArray NewIntArray(jsize len) {
        return functions.NewIntArray(cast(JNIEnv_*) &this, len);
    }
    jlongArray NewLongArray(jsize len) {
        return functions.NewLongArray(cast(JNIEnv_*) &this, len);
    }
    jfloatArray NewFloatArray(jsize len) {
        return functions.NewFloatArray(cast(JNIEnv_*) &this, len);
    }
    jdoubleArray NewDoubleArray(jsize len) {
        return functions.NewDoubleArray(cast(JNIEnv_*) &this, len);
    }

    jboolean* GetBooleanArrayElements(jbooleanArray array, jboolean* isCopy) {
        return functions.GetBooleanArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jbyte* GetByteArrayElements(jbyteArray array, jboolean* isCopy) {
        return functions.GetByteArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jchar* GetCharArrayElements(jcharArray array, jboolean* isCopy) {
        return functions.GetCharArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jshort* GetShortArrayElements(jshortArray array, jboolean* isCopy) {
        return functions.GetShortArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jint* GetIntArrayElements(jintArray array, jboolean* isCopy) {
        return functions.GetIntArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jlong* GetLongArrayElements(jlongArray array, jboolean* isCopy) {
        return functions.GetLongArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jfloat* GetFloatArrayElements(jfloatArray array, jboolean* isCopy) {
        return functions.GetFloatArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }
    jdouble* GetDoubleArrayElements(jdoubleArray array, jboolean* isCopy) {
        return functions.GetDoubleArrayElements(cast(JNIEnv_*) &this, array, isCopy);
    }

    void ReleaseBooleanArrayElements(jbooleanArray array, jboolean* elems, jint mode) {
        functions.ReleaseBooleanArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseByteArrayElements(jbyteArray array, jbyte* elems, jint mode) {
        functions.ReleaseByteArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseCharArrayElements(jcharArray array, jchar* elems, jint mode) {
        functions.ReleaseCharArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseShortArrayElements(jshortArray array, jshort* elems, jint mode) {
        functions.ReleaseShortArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseIntArrayElements(jintArray array, jint* elems, jint mode) {
        functions.ReleaseIntArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseLongArrayElements(jlongArray array, jlong* elems, jint mode) {
        functions.ReleaseLongArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseFloatArrayElements(jfloatArray array, jfloat* elems, jint mode) {
        functions.ReleaseFloatArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }
    void ReleaseDoubleArrayElements(jdoubleArray array, jdouble* elems, jint mode) {
        functions.ReleaseDoubleArrayElements(cast(JNIEnv_*) &this, array, elems, mode);
    }

    void GetBooleanArrayRegion(jbooleanArray array, jsize start, jsize len, jboolean* buf) {
        functions.GetBooleanArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetByteArrayRegion(jbyteArray array, jsize start, jsize len, jbyte* buf) {
        functions.GetByteArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetCharArrayRegion(jcharArray array, jsize start, jsize len, jchar* buf) {
        functions.GetCharArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetShortArrayRegion(jshortArray array, jsize start, jsize len, jshort* buf) {
        functions.GetShortArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetIntArrayRegion(jintArray array, jsize start, jsize len, jint* buf) {
        functions.GetIntArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetLongArrayRegion(jlongArray array, jsize start, jsize len, jlong* buf) {
        functions.GetLongArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetFloatArrayRegion(jfloatArray array, jsize start, jsize len, jfloat* buf) {
        functions.GetFloatArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void GetDoubleArrayRegion(jdoubleArray array, jsize start, jsize len, jdouble* buf) {
        functions.GetDoubleArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }

    void SetBooleanArrayRegion(jbooleanArray array, jsize start, jsize len, const jboolean* buf) {
        functions.SetBooleanArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetByteArrayRegion(jbyteArray array, jsize start, jsize len, const jbyte* buf) {
        functions.SetByteArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetCharArrayRegion(jcharArray array, jsize start, jsize len, const jchar* buf) {
        functions.SetCharArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetShortArrayRegion(jshortArray array, jsize start, jsize len, const jshort* buf) {
        functions.SetShortArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetIntArrayRegion(jintArray array, jsize start, jsize len, const jint* buf) {
        functions.SetIntArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetLongArrayRegion(jlongArray array, jsize start, jsize len, const jlong* buf) {
        functions.SetLongArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetFloatArrayRegion(jfloatArray array, jsize start, jsize len, const jfloat* buf) {
        functions.SetFloatArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }
    void SetDoubleArrayRegion(jdoubleArray array, jsize start, jsize len, const jdouble* buf) {
        functions.SetDoubleArrayRegion(cast(JNIEnv_*) &this, array, start, len, buf);
    }

    jint RegisterNatives(jclass clazz, const JNINativeMethod* methods, jint nMethods) {
        return functions.RegisterNatives(cast(JNIEnv_*) &this, clazz, methods, nMethods);
    }
    jint UnregisterNatives(jclass clazz) {
        return functions.UnregisterNatives(cast(JNIEnv_*) &this, clazz);
    }

    jint MonitorEnter(jobject obj) {
        return functions.MonitorEnter(cast(JNIEnv_*) &this, obj);
    }
    jint MonitorExit(jobject obj) {
        return functions.MonitorExit(cast(JNIEnv_*) &this, obj);
    }

    jint GetJavaVM(JavaVM** vm) {
        return functions.GetJavaVM(cast(JNIEnv_*) &this, vm);
    }

    void GetStringRegion(jstring str, jsize start, jsize len, jchar* buf) {
        functions.GetStringRegion(cast(JNIEnv_*) &this, str, start, len, buf);
    }
    void GetStringUTFRegion(jstring str, jsize start, jsize len, char* buf) {
        functions.GetStringUTFRegion(cast(JNIEnv_*) &this, str, start, len, buf);
    }

    void* GetPrimitiveArrayCritical(jarray array, jboolean* isCopy) {
        return functions.GetPrimitiveArrayCritical(cast(JNIEnv_*) &this, array, isCopy);
    }
    void ReleasePrimitiveArrayCritical(jarray array, void* carray, jint mode) {
        functions.ReleasePrimitiveArrayCritical(cast(JNIEnv_*) &this, array, carray, mode);
    }

    const jchar* GetStringCritical(jstring string_, jboolean* isCopy) {
        return cast(jchar*) functions.GetStringCritical(cast(JNIEnv_*) &this, string_, isCopy);
    }
    void ReleaseStringCritical(jstring string_, const jchar* cstring) {
        functions.ReleaseStringCritical(cast(JNIEnv_*) &this, string_, cstring);
    }

    jweak NewWeakGlobalRef(jobject obj) {
        return functions.NewWeakGlobalRef(cast(JNIEnv_*) &this, obj);
    }
    void DeleteWeakGlobalRef(jweak ref_) {
        functions.DeleteWeakGlobalRef(cast(JNIEnv_*) &this, ref_);
    }

    jboolean ExceptionCheck() {
        return functions.ExceptionCheck(cast(JNIEnv_*) &this);
    }

    jobject NewDirectByteBuffer(void* address, jlong capacity) {
        return functions.NewDirectByteBuffer(cast(JNIEnv_*) &this, address, capacity);
    }
    void* GetDirectBufferAddress(jobject buf) {
        return functions.GetDirectBufferAddress(cast(JNIEnv_*) &this, buf);
    }
    jlong GetDirectBufferCapacity(jobject buf) {
        return functions.GetDirectBufferCapacity(cast(JNIEnv_*) &this, buf);
    }

    jobjectRefType GetObjectRefType(jobject obj) {
        return functions.GetObjectRefType(cast(JNIEnv_*) &this, obj);
    }
}

struct JavaVMOption
{
    const(char)* optionString;
    void* extraInfo;
}

struct JavaVMInitArgs
{
    jint version_;

    jint nOptions;
    JavaVMOption* options;
    jboolean ignoreUnrecognized;
}

struct JavaVMAttachArgs
{
    jint version_;

    const(char)* name;
    jobject group;
}

/* These will be VM-specific. */

struct JNIInvokeInterface_
{
    void* reserved0;
    void* reserved1;
    void* reserved2;
    jint function(JavaVM* vm) DestroyJavaVM;
    jint function(JavaVM* vm, JNIEnv** penv, void* args) AttachCurrentThread;
    jint function(JavaVM* vm) DetachCurrentThread;
    jint function(JavaVM* vm, void** penv, jint version_) GetEnv;
    jint function(JavaVM* vm, JNIEnv** penv, void* args) AttachCurrentThreadAsDaemon;
}

struct JavaVM_
{
    const(JNIInvokeInterface_)* functions;

    jint DestroyJavaVM() {
        return functions.DestroyJavaVM(cast(JavaVM_*) &this);
    }
    jint AttachCurrentThread(void **penv, void *args) {
        return functions.AttachCurrentThread(cast(JavaVM_*) &this, cast(JNIEnv_**) penv, args);
    }
    jint DetachCurrentThread() {
        return functions.DetachCurrentThread(cast(JavaVM_*) &this);
    }

    jint GetEnv(void **penv, jint version_) {
        return functions.GetEnv(cast(JavaVM_*) &this, penv, version_);
    }
    jint AttachCurrentThreadAsDaemon(void **penv, void *args) {
        return functions.AttachCurrentThreadAsDaemon(cast(JavaVM_*) &this, cast(JNIEnv_**) penv, args);
    }
}

jint JNI_GetDefaultJavaVMInitArgs(void *args);
jint JNI_CreateJavaVM(JavaVM **pvm, void **penv, void *args);
jint JNI_GetCreatedJavaVMs(JavaVM **, jsize, jsize *);

jint JNI_OnLoad(JavaVM* vm, void* reserved);
void JNI_OnUnload(JavaVM* vm, void* reserved);

enum JNI_VERSION_1_1 = 0x00010001;
enum JNI_VERSION_1_2 = 0x00010002;
enum JNI_VERSION_1_4 = 0x00010004;
enum JNI_VERSION_1_6 = 0x00010006;
enum JNI_VERSION_1_8 = 0x00010008;
