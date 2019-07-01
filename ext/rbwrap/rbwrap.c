#include <ruby.h>

VALUE RbwrapModule = Qnil;
VALUE RbwrapClass = Qnil;

void Init_rbwrap();
VALUE rbwrap_initialize(VALUE self);

void Init_rbwrap() {
    RbwrapModule = rb_define_module("Rbwrap");
    RbwrapClass = rb_define_class_under(RbwrapModule, "Rbwrap", rb_cObject);
    rb_define_method(RbwrapClass, "initialize", rbwrap_initialize, 0);
}

VALUE rbwrap_initialize(VALUE self) {
    rb_iv_set(self, "@var", rb_hash_new());
    return self;
}

