#include <ruby.h>

VALUE RbwrapModule = Qnil;
VALUE RbwrapClass = Qnil;

void Init_rbwrap();
VALUE rbwrap_initialize(VALUE self);
static VALUE signal_handler_proc;
static int test_val = 0;
static int test_val2 = 0;

signal_handler_wrapper(VALUE arg, VALUE ctx)
{
  test_val = 1;
  return Qnil;
}

void Init_rbwrap() {
    signal_handler_proc = rb_proc_new(signal_handler_wrapper, Qnil);
    rb_global_variable(&signal_handler_proc);
    rb_funcall(Qnil, rb_intern("trap"), 2, rb_str_new_cstr("URG"), signal_handler_proc);

    RbwrapModule = rb_define_module("Rbwrap");
    RbwrapClass = rb_define_class_under(RbwrapModule, "Rbwrap", rb_cObject);
    rb_define_method(RbwrapClass, "initialize", rbwrap_initialize, 0);
}

VALUE rbwrap_initialize(VALUE self) {
    if (test_val == 0)  {
        rb_iv_set(self, "@var", rb_hash_new());
    }else{
        rb_iv_set(self, "@var", rb_ary_new());
    }
    return self;
}
