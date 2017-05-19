# billigastematkassen

Shopping support application :)

The idea is to be able to keep track of the prices for various item at the local supermarket, to be able to see "which place should I go to for the cheapest grand total of my shopping bag?" or "what items are exceptionally priced somewhere else than my default shop?".

For this to work, it presumes that the user will actually spend some time on entering the data into the system (the prices for the items at the different stores). No "magic" is involved there, it's all built on manual data entry.

## Technical details

Built with:

- Twitter Bootstrap
- CoffeeScript
- Redis
- Underscore (lodash) templates
- jQuery

I initially tried to implement this with an old version of Ember, but the performance was so bad that I resorted to go with plain jQuery for now.
