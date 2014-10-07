HYPNorwegianSSN
===============

A convenient way of validating and extracting infos from a Norwegian Social Security Number

``` objc
HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithSSN:@"xxxxxxxxxxx"];

if (ssn.isValid) {
    NSLog(@"Yeap, this is valid alright, tell me more about this so called person.");
    [self gainInterest:YES];
}

if (ssn.isDNumber) {
    NSLog(@"OMG! A potential swede");
    [self runAndHide];
}

if (ssn.isFemale) {
    NSLog(@"Oh, it's a woman!");
    [self comesBack];
}

NSLog(@"Are you sure? Remember what happened last time?");

if (!ssn.isMale) {
    NSLog(@"Yeah I'm sure, this is not an Aerosmith song!");
    [self startWhistlingOnTune:@"Aerosmith -  Dude (looks like a lady)"];
    NSLog(@"Doh!");
}

if (ssn.age > 18) {
    NSLog(@"Dear diary, jackpot");
    [self enableTheSmoulder:YES];
}

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Hyper made this. We're a digital communications agency with a passion for good code,
and if you're using this library we probably want to hire you.

## License

HYPNorwegianSSN is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hyperoslo/HYPNorwegianSSN/develop/README.md?token=57446__eyJzY29wZSI6IlJhd0Jsb2I6aHlwZXJvc2xvL0hZUE5vcndlZ2lhblNTTi9kZXZlbG9wL1JFQURNRS5tZCIsImV4cGlyZXMiOjE0MTMyNjYxNzZ9--982833554d17dacc13e570f50951c8e99c153b95) file for more info.
