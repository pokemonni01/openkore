#################################################################################################
#  OpenKore - Network subsystem									#
#  This module contains functions for sending messages to the server.				#
#												#
#  This software is open source, licensed under the GNU General Public				#
#  License, version 2.										#
#  Basically, this means that you're allowed to modify and distribute				#
#  this software. However, if you distribute modified versions, you MUST			#
#  also distribute the source code.								#
#  See http://www.gnu.org/licenses/gpl.html for the full license.				#
#################################################################################################
# tRO (Thai)
package Network::Send::tRO;
use strict;
use base qw(Network::Send::ServerType0);

sub new {
        my ($class) = @_;
        my $self = $class->SUPER::new(@_);
        
         my %packets = (
                '0437' => ['actor_action', 'a4 C', [qw(targetID type)]],
                '035F' => ['character_move','a3', [qw(coords)]],
                '0360' => ['sync', 'V', [qw(time)]],
                '0361' => ['actor_look_at', 'v C', [qw(head body)]],
                '0362' => ['item_take', 'a4', [qw(ID)]],
                '0363' => ['item_drop', 'v2', [qw(index amount)]],
                '023B' => ['storage_password'],
                '0364' => ['storage_item_add', 'v V', [qw(index amount)]],
                '0365' => ['storage_item_remove', 'v V', [qw(index amount)]],
                '0366' => ['skill_use_location', 'v4', [qw(lv skillID x y)]],
                '0368' => ['actor_info_request', 'a4', [qw(ID)]],
                '3A41' => ['map_login', 'a4 a4 a4 V C', [qw(accountID charID sessionID tick sex)]],
                '022D' => ['party_join_request_by_name', 'Z24', [qw(partyName)]],
                '0802' => ['homunculus_command', 'v C', [qw(commandType, commandID)]],
        );
        
        $self->{packet_list}{$_} = $packets{$_} for keys %packets;        
        
        my %handlers = qw(
                game_login 0275
                actor_action 0437
                character_move 035F
                sync 0360
                actor_look_at 0361
                item_take 0362
                item_drop 0363
                storage_password 023B
                storage_item_add 0364
                storage_item_remove 0365
                skill_use_location 0366
                actor_info_request 0368
                map_login 3A41
                party_join_request_by_name 022D
                homunculus_command 0802
                party_setting 07D7
                buy_bulk_vender 0801
        );
	
	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
	$self->cryptKeys(0x4d8e77b2, 0x6e7b6757, 0x46ae0414);
	return $self;
}

1;