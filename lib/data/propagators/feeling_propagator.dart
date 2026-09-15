import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/feelings/feelings.dart';
import 'package:system_mapper/data/model_classes/propagator.dart';
import 'package:system_mapper/utils/current.dart';

class FeelingPropagator extends Propagator<FeelingsList> {
  bool? _hasPropagated;

  @override
  void propagate() {
    current?.firstOrderFeelings = [
      Feeling(feelingName: 'Happy'),
      Feeling(feelingName: 'Sad'),
      Feeling(feelingName: 'Disgusted'),
      Feeling(feelingName: 'Angry'),
      Feeling(feelingName: 'Hindered'),
      Feeling(feelingName: 'Fearful'),
      Feeling(feelingName: 'Surprised'),
    ];
    current?.secondOrderFeelings = [
      Feeling(feelingName: 'Playful', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Content', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Interested', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Proud', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Accepted', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Powerful', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Peaceful', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Trusting', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Optimistic', feelingParentName: 'Happy'),
      Feeling(feelingName: 'Lonely', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Vulnerable', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Despair', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Guilty', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Depressed', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Hurt', feelingParentName: 'Sad'),
      Feeling(feelingName: 'Disapproving', feelingParentName: 'Disgusted'),
      Feeling(feelingName: 'Disappointed', feelingParentName: 'Disgusted'),
      Feeling(feelingName: 'Awful', feelingParentName: 'Disgusted'),
      Feeling(feelingName: 'Repelled', feelingParentName: 'Disgusted'),
      Feeling(feelingName: 'Let down', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Humiliated', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Bitter', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Passionate', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Aggressive', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Frustrated', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Distant', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Critical', feelingParentName: 'Angry'),
      Feeling(feelingName: 'Scared', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Anxious', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Insecure', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Weak', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Rejected', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Threatened', feelingParentName: 'Fearful'),
      Feeling(feelingName: 'Bored', feelingParentName: 'Hindered'),
      Feeling(feelingName: 'Stressed', feelingParentName: 'Hindered'),
      Feeling(feelingName: 'Busy', feelingParentName: 'Hindered'),
      Feeling(feelingName: 'Tired', feelingParentName: 'Hindered'),
      Feeling(feelingName: 'Startled', feelingParentName: 'Surprised'),
      Feeling(feelingName: 'Confused', feelingParentName: 'Surprised'),
      Feeling(feelingName: 'Amazed', feelingParentName: 'Surprised'),
      Feeling(feelingName: 'Excited', feelingParentName: 'Surprised'),
    ];
    current?.thirdOrderFeelings = [
      Feeling(feelingParentName: 'Playful', feelingName: 'Aroused'),
      Feeling(feelingParentName: 'Playful', feelingName: 'Cheeky'),
      Feeling(feelingParentName: 'Content', feelingName: 'Free'),
      Feeling(feelingParentName: 'Content', feelingName: 'Joyful'),
      Feeling(feelingParentName: 'Interested', feelingName: 'Curious'),
      Feeling(feelingParentName: 'Interested', feelingName: 'Inquisitive'),
      Feeling(feelingParentName: 'Proud', feelingName: 'Successful'),
      Feeling(feelingParentName: 'Proud', feelingName: 'Confident'),
      Feeling(feelingParentName: 'Accepted', feelingName: 'Respected'),
      Feeling(feelingParentName: 'Accepted', feelingName: 'Valued'),
      Feeling(feelingParentName: 'Powerful', feelingName: 'Courageous'),
      Feeling(feelingParentName: 'Powerful', feelingName: 'Creative'),
      Feeling(feelingParentName: 'Peaceful', feelingName: 'Loving'),
      Feeling(feelingParentName: 'Peaceful', feelingName: 'Thankful'),
      Feeling(feelingParentName: 'Trusting', feelingName: 'Sensitive'),
      Feeling(feelingParentName: 'Trusting', feelingName: 'Intimate'),
      Feeling(feelingParentName: 'Optimistic', feelingName: 'Hopeful'),
      Feeling(feelingParentName: 'Optimistic', feelingName: 'Inspired'),
      Feeling(feelingParentName: 'Lonely', feelingName: 'Isolated'),
      Feeling(feelingParentName: 'Lonely', feelingName: 'Abandoned'),
      Feeling(feelingParentName: 'Vulnerable', feelingName: 'Victimised'),
      Feeling(feelingParentName: 'Vulnerable', feelingName: 'Fragile'),
      Feeling(feelingParentName: 'Despair', feelingName: 'Grief-stricken'),
      Feeling(feelingParentName: 'Despair', feelingName: 'Powerless'),
      Feeling(feelingParentName: 'Guilty', feelingName: 'Ashamed'),
      Feeling(feelingParentName: 'Guilty', feelingName: 'Remorseful'),
      Feeling(feelingParentName: 'Depressed', feelingName: 'Empty'),
      Feeling(feelingParentName: 'Depressed', feelingName: 'Inferior'),
      Feeling(feelingParentName: 'Hurt', feelingName: 'Disappointed'),
      Feeling(feelingParentName: 'Hurt', feelingName: 'Embarrassed'),
      Feeling(feelingParentName: 'Disapproving', feelingName: 'Judgemental'),
      Feeling(feelingParentName: 'Disapproving', feelingName: 'Embarrassed'),
      Feeling(feelingParentName: 'Disappointed', feelingName: 'Appalled'),
      Feeling(feelingParentName: 'Disappointed', feelingName: 'Revolted'),
      Feeling(feelingParentName: 'Awful', feelingName: 'Nauseated'),
      Feeling(feelingParentName: 'Awful', feelingName: 'Detestable'),
      Feeling(feelingParentName: 'Repelled', feelingName: 'Horrified'),
      Feeling(feelingParentName: 'Repelled', feelingName: 'Hesitant'),
      Feeling(feelingParentName: 'Let down', feelingName: 'Betrayed'),
      Feeling(feelingParentName: 'Let down', feelingName: 'Resentful'),
      Feeling(feelingParentName: 'Humiliated', feelingName: 'Disrespected'),
      Feeling(feelingParentName: 'Humiliated', feelingName: 'Ridiculed'),
      Feeling(feelingParentName: 'Bitter', feelingName: 'Indignant'),
      Feeling(feelingParentName: 'Bitter', feelingName: 'Violated'),
      Feeling(feelingParentName: 'Passionate', feelingName: 'Furious'),
      Feeling(feelingParentName: 'Passionate', feelingName: 'Jealous'),
      Feeling(feelingParentName: 'Aggressive', feelingName: 'Provoked'),
      Feeling(feelingParentName: 'Aggressive', feelingName: 'Hostile'),
      Feeling(feelingParentName: 'Frustrated', feelingName: 'Infuriated'),
      Feeling(feelingParentName: 'Frustrated', feelingName: 'Annoyed'),
      Feeling(feelingParentName: 'Distant', feelingName: 'Withdrawn'),
      Feeling(feelingParentName: 'Distant', feelingName: 'Numb'),
      Feeling(feelingParentName: 'Critical', feelingName: 'Sceptical'),
      Feeling(feelingParentName: 'Critical', feelingName: 'Dismissive'),
      Feeling(feelingParentName: 'Scared', feelingName: 'Helpless'),
      Feeling(feelingParentName: 'Scared', feelingName: 'Frightened'),
      Feeling(feelingParentName: 'Anxious', feelingName: 'Overwhelmed'),
      Feeling(feelingParentName: 'Anxious', feelingName: 'Worried'),
      Feeling(feelingParentName: 'Insecure', feelingName: 'Inadequate'),
      Feeling(feelingParentName: 'Insecure', feelingName: 'Inferior'),
      Feeling(feelingParentName: 'Weak', feelingName: 'Worthless'),
      Feeling(feelingParentName: 'Weak', feelingName: 'Insignificant'),
      Feeling(feelingParentName: 'Rejected', feelingName: 'Excluded'),
      Feeling(feelingParentName: 'Rejected', feelingName: 'Persecuted'),
      Feeling(feelingParentName: 'Threatened', feelingName: 'Nervous'),
      Feeling(feelingParentName: 'Threatened', feelingName: 'Exposed'),
      Feeling(feelingParentName: 'Bored', feelingName: 'Indifferent'),
      Feeling(feelingParentName: 'Bored', feelingName: 'Apathetic'),
      Feeling(feelingParentName: 'Stressed', feelingName: 'Overwhelmed'),
      Feeling(feelingParentName: 'Stressed', feelingName: 'Out of control'),
      Feeling(feelingParentName: 'Busy', feelingName: 'Pressured'),
      Feeling(feelingParentName: 'Busy', feelingName: 'Rushed'),
      Feeling(feelingParentName: 'Tired', feelingName: 'Sleepy'),
      Feeling(feelingParentName: 'Tired', feelingName: 'Unfocused'),
      Feeling(feelingParentName: 'Startled', feelingName: 'Shocked'),
      Feeling(feelingParentName: 'Startled', feelingName: 'Dismayed'),
      Feeling(feelingParentName: 'Confused', feelingName: 'Disillusioned'),
      Feeling(feelingParentName: 'Confused', feelingName: 'Perplexed'),
      Feeling(feelingParentName: 'Amazed', feelingName: 'Astonished'),
      Feeling(feelingParentName: 'Amazed', feelingName: 'Awe'),
      Feeling(feelingParentName: 'Excited', feelingName: 'Eager'),
      Feeling(feelingParentName: 'Excited', feelingName: 'Energetic'),
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
