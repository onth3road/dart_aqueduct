# Client Log

## March 7
I have to say, learning something from web open course makes me feel great, it's like suddenly I got such amazing ablity to make things easy, elegant and effective. But in reality, it took hours to figure out why it not working, which seems like a level 101 problem...

### Global styling is neccessary, this one need scss.
1. add a build.yaml in root dir, in this case is client dir adding following lines:
```yaml
targets:
  $default:
    builders:
      angular_components|scss_builder:
        enabled: True
```
2. in my case I add a _styles.scss as a globle styling file then in other files could using following to refer it: (path depending on where to access it)
```scss
@import 'styles';
```
3. in component dart file, it should be linked as:
```dart
@Component {
  ...
  styleUrls: ['app_component.scss.css'],
  ...
}
```

### Font is a pain
isplaying digital text
