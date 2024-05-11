// MIT license
//
// Copyright 2024 Per Nilsson
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

const parse = require('./yang').parse;

function evaluate(yang) {
  const json = parse(yang);
  return json;
}

function indent(data, level) {
  const indentaion = "  ";
  let result = "";
  for (let i = 0; i < level; i++) {
    result += indentaion;
  }
  result += data;
  return result; 
}

function bodyToString(value, level) {
  if (value.body.length === 0) {
    return ";";
  }
  let result = " {\n";
  for (let i = 0; i < value.body.length; i ++) { 
    result += toString(value.body[i], level + 1);
    result += '\n'
  }
  result += indent("}", level);
  return result;
}

function toString(value, level) {
  if (typeof level === 'undefined') {
    level = 0;
  }
  result = "";
  if (typeof value === 'object') {
    result += indent(`${value.type} ${value.name}`, level);
    result += bodyToString(value, level);
  }
  return result;
}

exports.evaluate = evaluate;
exports.toString = toString;
