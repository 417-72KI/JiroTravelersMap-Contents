Array.prototype.ifEmpty = function(trueValue, falseBlock) {
    if (typeof falseBlock !== 'function') {
        throw new TypeError('falseBlock must be a function');
    }
    if (this.length === 0) {
        return trueValue;
    } else {
        return falseBlock(this);
    }
}
