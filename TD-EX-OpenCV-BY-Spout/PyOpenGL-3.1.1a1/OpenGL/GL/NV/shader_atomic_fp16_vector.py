'''OpenGL extension NV.shader_atomic_fp16_vector

This module customises the behaviour of the 
OpenGL.raw.GL.NV.shader_atomic_fp16_vector to provide a more 
Python-friendly API

The official definition of this extension is available here:
http://www.opengl.org/registry/specs/NV/shader_atomic_fp16_vector.txt
'''
from OpenGL import platform, constant, arrays
from OpenGL import extensions, wrapper
import ctypes
from OpenGL.raw.GL import _types, _glgets
from OpenGL.raw.GL.NV.shader_atomic_fp16_vector import *
from OpenGL.raw.GL.NV.shader_atomic_fp16_vector import _EXTENSION_NAME

def glInitShaderAtomicFp16VectorNV():
    '''Return boolean indicating whether this extension is available'''
    from OpenGL import extensions
    return extensions.hasGLExtension( _EXTENSION_NAME )


### END AUTOGENERATED SECTION