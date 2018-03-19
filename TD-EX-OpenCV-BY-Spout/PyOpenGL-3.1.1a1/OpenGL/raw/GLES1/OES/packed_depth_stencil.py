'''Autogenerated by xml_generate script, do not edit!'''
from OpenGL import platform as _p, arrays
# Code generation uses this
from OpenGL.raw.GLES1 import _types as _cs
# End users want this...
from OpenGL.raw.GLES1._types import *
from OpenGL.raw.GLES1 import _errors
from OpenGL.constant import Constant as _C

import ctypes
_EXTENSION_NAME = 'GLES1_OES_packed_depth_stencil'
def _f( function ):
    return _p.createFunction( function,_p.PLATFORM.GLES1,'GLES1_OES_packed_depth_stencil',error_checker=_errors._error_checker)
GL_DEPTH24_STENCIL8_OES=_C('GL_DEPTH24_STENCIL8_OES',0x88F0)
GL_DEPTH_STENCIL_OES=_C('GL_DEPTH_STENCIL_OES',0x84F9)
GL_UNSIGNED_INT_24_8_OES=_C('GL_UNSIGNED_INT_24_8_OES',0x84FA)

