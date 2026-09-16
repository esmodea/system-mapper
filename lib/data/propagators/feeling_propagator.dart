import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/feelings/feelings.dart';
import 'package:system_mapper/data/model_classes/propagator.dart';
import 'package:system_mapper/utils/current.dart';

class FeelingPropagator extends Propagator<FeelingsList> {
  bool? _hasPropagated;

  @override
  void propagate() {
    current?.firstOrderFeelings = [
      Feeling(feelingName: 'Happy', emojiCode: '😄'),
      Feeling(feelingName: 'Sad', emojiCode: '😢'),
      Feeling(feelingName: 'Disgusted', emojiCode: '🤢'),
      Feeling(feelingName: 'Angry', emojiCode: '😡'),
      Feeling(feelingName: 'Hindered', emojiCode: '🫩'),
      Feeling(feelingName: 'Fearful', emojiCode: '😱'),
      Feeling(feelingName: 'Surprised', emojiCode: '😨'),
    ];
    current?.secondOrderFeelings = [
      Feeling(
        feelingName: 'Playful',
        feelingParentName: 'Happy',
        emojiCode: '🤪',
      ),
      Feeling(
        feelingName: 'Content',
        feelingParentName: 'Happy',
        emojiCode: '😎',
      ),
      Feeling(
        feelingName: 'Interested',
        feelingParentName: 'Happy',
        emojiCode: '🤔',
      ),
      Feeling(
        feelingName: 'Proud',
        feelingParentName: 'Happy',
        emojiCode: '💪',
      ),
      Feeling(
        feelingName: 'Accepted',
        feelingParentName: 'Happy',
        emojiCode: '🤗',
      ),
      Feeling(
        feelingName: 'Powerful',
        feelingParentName: 'Happy',
        emojiCode: '😤',
      ),
      Feeling(
        feelingName: 'Peaceful',
        feelingParentName: 'Happy',
        emojiCode: '😇',
      ),
      Feeling(
        feelingName: 'Trusting',
        feelingParentName: 'Happy',
        emojiCode: '😌',
      ),
      Feeling(
        feelingName: 'Optimistic',
        feelingParentName: 'Happy',
        emojiCode: '🥹',
      ),
      Feeling(
        feelingName: 'Lonely',
        feelingParentName: 'Sad',
        emojiCode: '🫥',
        id: null,
      ),
      Feeling(
        feelingName: 'Vulnerable',
        feelingParentName: 'Sad',
        emojiCode: '🥺',
      ),
      Feeling(
        feelingName: 'Despair',
        feelingParentName: 'Sad',
        emojiCode: '😭',
      ),
      Feeling(
        feelingName: 'Guilty',
        feelingParentName: 'Sad',
        emojiCode: '😳',
        id: null,
      ),
      Feeling(
        feelingName: 'Depressed',
        feelingParentName: 'Sad',
        emojiCode: '😔',
      ),
      Feeling(
        feelingName: 'Hurt',
        feelingParentName: 'Sad',
        emojiCode: '🤕',
        id: null,
      ),
      Feeling(
        feelingName: 'Disapproving',
        feelingParentName: 'Disgusted',
        emojiCode: '🤨',
      ),
      Feeling(
        feelingName: 'Disappointed',
        feelingParentName: 'Disgusted',
        emojiCode: '🫤',
      ),
      Feeling(
        feelingName: 'Awful',
        feelingParentName: 'Disgusted',
        emojiCode: '🤢',
      ),
      Feeling(
        feelingName: 'Repelled',
        feelingParentName: 'Disgusted',
        emojiCode: '☹️',
      ),
      Feeling(
        feelingName: 'Let down',
        feelingParentName: 'Angry',
        emojiCode: '😔',
      ),
      Feeling(
        feelingName: 'Humiliated',
        feelingParentName: 'Angry',
        emojiCode: '🫣',
      ),
      Feeling(
        feelingName: 'Bitter',
        feelingParentName: 'Angry',
        emojiCode: '😠',
      ),
      Feeling(
        feelingName: 'Passionate',
        feelingParentName: 'Angry',
        emojiCode: '😤',
      ),
      Feeling(
        feelingName: 'Aggressive',
        feelingParentName: 'Angry',
        emojiCode: '🤬',
      ),
      Feeling(
        feelingName: 'Frustrated',
        feelingParentName: 'Angry',
        emojiCode: '😡',
      ),
      Feeling(
        feelingName: 'Distant',
        feelingParentName: 'Angry',
        emojiCode: '😶',
      ),
      Feeling(
        feelingName: 'Critical',
        feelingParentName: 'Angry',
        emojiCode: '🤨',
      ),
      Feeling(
        feelingName: 'Scared',
        feelingParentName: 'Fearful',
        emojiCode: '😨',
      ),
      Feeling(
        feelingName: 'Anxious',
        feelingParentName: 'Fearful',
        emojiCode: '😟',
      ),
      Feeling(
        feelingName: 'Insecure',
        feelingParentName: 'Fearful',
        emojiCode: '😅',
      ),
      Feeling(
        feelingName: 'Weak',
        feelingParentName: 'Fearful',
        emojiCode: '😞',
      ),
      Feeling(
        feelingName: 'Rejected',
        feelingParentName: 'Fearful',
        emojiCode: '🫠',
      ),
      Feeling(
        feelingName: 'Threatened',
        feelingParentName: 'Fearful',
        emojiCode: '👊',
      ),
      Feeling(
        feelingName: 'Bored',
        feelingParentName: 'Hindered',
        emojiCode: '🫩',
      ),
      Feeling(
        feelingName: 'Stressed',
        feelingParentName: 'Hindered',
        emojiCode: '😧',
      ),
      Feeling(
        feelingName: 'Busy',
        feelingParentName: 'Hindered',
        emojiCode: '📈',
      ),
      Feeling(
        feelingName: 'Tired',
        feelingParentName: 'Hindered',
        emojiCode: '😴',
      ),
      Feeling(
        feelingName: 'Startled',
        feelingParentName: 'Surprised',
        emojiCode: '🫨',
      ),
      Feeling(
        feelingName: 'Confused',
        feelingParentName: 'Surprised',
        emojiCode: '😵‍💫',
      ),
      Feeling(
        feelingName: 'Amazed',
        feelingParentName: 'Surprised',
        emojiCode: '😳',
      ),
      Feeling(
        feelingName: 'Excited',
        feelingParentName: 'Surprised',
        emojiCode: '🤩',
      ),
    ];
    current?.thirdOrderFeelings = [
      Feeling(
        feelingName: 'Aroused',
        feelingParentName: 'Playful',
        emojiCode: '🥵',
      ),
      Feeling(
        feelingName: 'Cheeky',
        feelingParentName: 'Playful',
        emojiCode: '😉',
      ),
      Feeling(
        feelingName: 'Free',
        feelingParentName: 'Content',
        emojiCode: '🌊',
      ),
      Feeling(
        feelingName: 'Joyful',
        feelingParentName: 'Content',
        emojiCode: '😂',
      ),
      Feeling(
        feelingName: 'Curious',
        feelingParentName: 'Interested',
        emojiCode: '🤨',
      ),
      Feeling(
        feelingName: 'Inquisitive',
        feelingParentName: 'Interested',
        emojiCode: '🤔',
      ),
      Feeling(
        feelingName: 'Successful',
        feelingParentName: 'Proud',
        emojiCode: '🤑',
      ),
      Feeling(
        feelingName: 'Confident',
        feelingParentName: 'Proud',
        emojiCode: '😤',
      ),
      Feeling(
        feelingName: 'Respected',
        feelingParentName: 'Accepted',
        emojiCode: '🫡',
      ),
      Feeling(
        feelingName: 'Valued',
        feelingParentName: 'Accepted',
        emojiCode: '🤑',
      ),
      Feeling(
        feelingName: 'Courageous',
        feelingParentName: 'Powerful',
        emojiCode: '😤',
      ),
      Feeling(
        feelingName: 'Creative',
        feelingParentName: 'Powerful',
        emojiCode: '🖌️',
      ),
      Feeling(
        feelingName: 'Loving',
        feelingParentName: 'Peaceful',
        emojiCode: '🥰',
      ),
      Feeling(
        feelingName: 'Thankful',
        feelingParentName: 'Peaceful',
        emojiCode: '🫂',
      ),
      Feeling(
        feelingName: 'Sensitive',
        feelingParentName: 'Trusting',
        emojiCode: '🥹',
      ),
      Feeling(
        feelingName: 'Intimate',
        feelingParentName: 'Trusting',
        emojiCode: '🫂',
      ),
      Feeling(
        feelingName: 'Hopeful',
        feelingParentName: 'Optimistic',
        emojiCode: '🥹',
      ),
      Feeling(
        feelingName: 'Inspired',
        feelingParentName: 'Optimistic',
        emojiCode: '💡',
      ),
      Feeling(
        feelingName: 'Isolated',
        feelingParentName: 'Lonely',
        emojiCode: '😶‍🌫️',
      ),
      Feeling(
        feelingName: 'Abandoned',
        feelingParentName: 'Lonely',
        emojiCode: '🫥',
      ),
      Feeling(
        feelingName: 'Victimised',
        feelingParentName: 'Vulnerable',
        emojiCode: '🤕',
      ),
      Feeling(
        feelingName: 'Fragile',
        feelingParentName: 'Vulnerable',
        emojiCode: '💔',
      ),
      Feeling(
        feelingName: 'Grief-stricken',
        feelingParentName: 'Despair',
        emojiCode: '😩',
      ),
      Feeling(
        feelingName: 'Powerless',
        feelingParentName: 'Despair',
        emojiCode: '😟',
      ),
      Feeling(
        feelingName: 'Ashamed',
        feelingParentName: 'Guilty',
        emojiCode: '😳',
      ),
      Feeling(
        feelingName: 'Remorseful',
        feelingParentName: 'Guilty',
        emojiCode: '😔',
      ),
      Feeling(
        feelingName: 'Empty',
        feelingParentName: 'Depressed',
        emojiCode: '🫥',
      ),
      Feeling(
        feelingName: 'Inferior',
        feelingParentName: 'Depressed',
        emojiCode: '📊',
      ),
      Feeling(
        feelingName: 'Disappointed',
        feelingParentName: 'Hurt',
        emojiCode: '😞',
      ),
      Feeling(
        feelingName: 'Embarrassed',
        feelingParentName: 'Hurt',
        emojiCode: '😡',
      ),
      Feeling(
        feelingName: 'Judgemental',
        feelingParentName: 'Disapproving',
        emojiCode: '😠',
      ),
      Feeling(
        feelingName: 'Embarrassed',
        feelingParentName: 'Disapproving',
        emojiCode: '😮',
      ),
      Feeling(
        feelingName: 'Appalled',
        feelingParentName: 'Disappointed',
        emojiCode: '😮',
      ),
      Feeling(
        feelingName: 'Revolted',
        feelingParentName: 'Disappointed',
        emojiCode: '🤢',
      ),
      Feeling(
        feelingName: 'Nauseated',
        feelingParentName: 'Awful',
        emojiCode: '🤢',
      ),
      Feeling(
        feelingName: 'Detestable',
        feelingParentName: 'Awful',
        emojiCode: '😡',
      ),
      Feeling(
        feelingName: 'Horrified',
        feelingParentName: 'Repelled',
        emojiCode: '😱',
      ),
      Feeling(
        feelingName: 'Hesitant',
        feelingParentName: 'Repelled',
        emojiCode: '🫢',
      ),
      Feeling(
        feelingName: 'Betrayed',
        feelingParentName: 'Let down',
        emojiCode: '😓',
      ),
      Feeling(
        feelingName: 'Resentful',
        feelingParentName: 'Let down',
        emojiCode: '😡',
      ),
      Feeling(
        feelingName: 'Disrespected',
        feelingParentName: 'Humiliated',
        emojiCode: '😠',
      ),
      Feeling(
        feelingName: 'Ridiculed',
        feelingParentName: 'Humiliated',
        emojiCode: '🤡',
      ),
      Feeling(
        feelingName: 'Indignant',
        feelingParentName: 'Bitter',
        emojiCode: '😐',
      ),
      Feeling(
        feelingName: 'Violated',
        feelingParentName: 'Bitter',
        emojiCode: '😨',
      ),
      Feeling(
        feelingName: 'Furious',
        feelingParentName: 'Passionate',
        emojiCode: '🤬',
      ),
      Feeling(
        feelingName: 'Jealous',
        feelingParentName: 'Passionate',
        emojiCode: '😳',
      ),
      Feeling(
        feelingName: 'Provoked',
        feelingParentName: 'Aggressive',
        emojiCode: '😠',
      ),
      Feeling(
        feelingName: 'Hostile',
        feelingParentName: 'Aggressive',
        emojiCode: '💢',
      ),
      Feeling(
        feelingName: 'Infuriated',
        feelingParentName: 'Frustrated',
        emojiCode: '😤',
      ),
      Feeling(
        feelingName: 'Annoyed',
        feelingParentName: 'Frustrated',
        emojiCode: '😡',
      ),
      Feeling(
        feelingName: 'Withdrawn',
        feelingParentName: 'Distant',
        emojiCode: '🫣',
      ),
      Feeling(
        feelingName: 'Numb',
        feelingParentName: 'Distant',
        emojiCode: '🫥',
      ),
      Feeling(
        feelingName: 'Sceptical',
        feelingParentName: 'Critical',
        emojiCode: '🤨',
      ),
      Feeling(
        feelingName: 'Dismissive',
        feelingParentName: 'Critical',
        emojiCode: '😑',
      ),
      Feeling(
        feelingName: 'Helpless',
        feelingParentName: 'Scared',
        emojiCode: '😟',
      ),
      Feeling(
        feelingName: 'Frightened',
        feelingParentName: 'Scared',
        emojiCode: '😱',
      ),
      Feeling(
        feelingName: 'Overwhelmed',
        feelingParentName: 'Anxious',
        emojiCode: '😵‍💫',
      ),
      Feeling(
        feelingName: 'Worried',
        feelingParentName: 'Anxious',
        emojiCode: '😟',
      ),
      Feeling(
        feelingName: 'Inadequate',
        feelingParentName: 'Insecure',
        emojiCode: '🥺',
      ),
      Feeling(
        feelingName: 'Inferior',
        feelingParentName: 'Insecure',
        emojiCode: '📉',
      ),
      Feeling(
        feelingName: 'Worthless',
        feelingParentName: 'Weak',
        emojiCode: '💩',
      ),
      Feeling(
        feelingName: 'Insignificant',
        feelingParentName: 'Weak',
        emojiCode: '🐞',
      ),
      Feeling(
        feelingName: 'Excluded',
        feelingParentName: 'Rejected',
        emojiCode: '🫥',
      ),
      Feeling(
        feelingName: 'Persecuted',
        feelingParentName: 'Rejected',
        emojiCode: '😲',
      ),
      Feeling(
        feelingName: 'Nervous',
        feelingParentName: 'Threatened',
        emojiCode: '😅',
      ),
      Feeling(
        feelingName: 'Exposed',
        feelingParentName: 'Threatened',
        emojiCode: '😮',
      ),
      Feeling(
        feelingName: 'Indifferent',
        feelingParentName: 'Bored',
        emojiCode: '😒',
      ),
      Feeling(
        feelingName: 'Apathetic',
        feelingParentName: 'Bored',
        emojiCode: '🙄',
      ),
      Feeling(
        feelingName: 'Overwhelmed',
        feelingParentName: 'Stressed',
        emojiCode: '😱',
      ),
      Feeling(
        feelingName: 'Out of control',
        feelingParentName: 'Stressed',
        emojiCode: '😵‍💫',
      ),
      Feeling(
        feelingName: 'Pressured',
        feelingParentName: 'Busy',
        emojiCode: '🚨',
      ),
      Feeling(
        feelingName: 'Rushed',
        feelingParentName: 'Busy',
        emojiCode: '⏲️',
      ),
      Feeling(
        feelingName: 'Sleepy',
        feelingParentName: 'Tired',
        emojiCode: '😪',
      ),
      Feeling(
        feelingName: 'Unfocused',
        feelingParentName: 'Tired',
        emojiCode: '😣',
      ),
      Feeling(
        feelingName: 'Shocked',
        feelingParentName: 'Startled',
        emojiCode: '🤯',
      ),
      Feeling(
        feelingName: 'Dismayed',
        feelingParentName: 'Startled',
        emojiCode: '😟',
      ),
      Feeling(
        feelingName: 'Disillusioned',
        feelingParentName: 'Confused',
        emojiCode: '😒',
      ),
      Feeling(
        feelingName: 'Perplexed',
        feelingParentName: 'Confused',
        emojiCode: '😵‍💫',
      ),
      Feeling(
        feelingName: 'Astonished',
        feelingParentName: 'Amazed',
        emojiCode: '😲',
      ),
      Feeling(
        feelingName: 'Awe',
        feelingParentName: 'Amazed',
        emojiCode: '🤯',
        id: null,
      ),
      Feeling(
        feelingName: 'Eager',
        feelingParentName: 'Excited',
        emojiCode: '😁',
      ),
      Feeling(
        feelingName: 'Energetic',
        feelingParentName: 'Excited',
        emojiCode: '🤩',
      ),
    ];
  }

  @override
  FeelingsList? get current => Current.feelings;

  @override
  bool get hasPropagated {
    if (_hasPropagated == null) {
      propagate();
      _hasPropagated = true;
      return true;
    } else {
      return _hasPropagated!;
    }
  }
}
