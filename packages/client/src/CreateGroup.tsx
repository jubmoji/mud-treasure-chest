import { HeyAuthn } from "@semaphore-protocol/heyauthn";
import { Group, BigNumberish } from "@semaphore-protocol/group";
import { Identity } from "@semaphore-protocol/identity";
import { useState } from "react";

export const heyAuthnOptions = {
  rpName: "treasure-chest",
  rpID: window.location.hostname,
  userID: "my-id",
  userName: "my-name",
};

export const CreateGroup = () => {
  const [identity, setIdentity] = useState<Identity | null>(null);
  const [root, setRoot] = useState<BigNumberish>("");

  const createIdentity = async () => {
    const { identity } = await HeyAuthn.fromRegister(heyAuthnOptions);
    setIdentity(identity);
  };

  const createGroup = () => {
    if (!identity) return;

    const identity1 = new Identity();
    const identity2 = new Identity();
    const identity3 = new Identity();

    const guild = new Group("1", 16, [
      identity.commitment,
      identity1.commitment,
      identity2.commitment,
      identity3.commitment,
    ]);
    setRoot(guild.root);
  };

  return (
    <div>
      <button onClick={createIdentity}>Create Identity</button>
      <button onClick={createGroup}>Create Group</button>
      <input type="text" value={root.toString()} readOnly />
    </div>
  );
};
