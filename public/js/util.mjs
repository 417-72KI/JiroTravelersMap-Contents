if (!('ifEmpty' in Array.prototype)) {
    Object.defineProperty(Array.prototype, 'ifEmpty', {
        value: function(trueValue, falseBlock) {
            if (this.length === 0) {
                return trueValue;
            }
            if (typeof falseBlock !== 'function') {
                throw new TypeError('falseBlock must be a function');
            }
            return falseBlock(this);
        },
        enumerable: false,
    });
}
